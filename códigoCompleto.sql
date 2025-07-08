CREATE TABLE Direccion (
    id_direccion VARCHAR(5) PRIMARY KEY NOT NULL,
    no_ext VARCHAR(10) NOT NULL,
    clave_localidad VARCHAR(20) NOT NULL,
    alcaldia VARCHAR(50) NOT NULL,
    no_int VARCHAR(10) NOT NULL,
    clave_municipio VARCHAR(20) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    colonia VARCHAR(100) NOT NULL,
    cp VARCHAR(10)
);

CREATE TABLE Equipo (
    id_equipo VARCHAR(5) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_creacion DATE NOT NULL
);

CREATE TABLE Persona (
    id_persona VARCHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    curp VARCHAR(18) NOT NULL,
    rfc VARCHAR(13) NOT NULL,
    ape_pat VARCHAR(50) NOT NULL,
    ape_mat VARCHAR(50) NOT NULL,
    tel_fijo VARCHAR(15) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    tel_mov VARCHAR(15) NOT NULL,
    tipo_persona CHAR(1) NOT NULL, -- 'P': personal, 'E': estudiante
    id_direccion VARCHAR(5) NOT NULL REFERENCES Direccion(id_direccion)
);

CREATE TABLE Personal (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Persona(id_persona),
    fecha_nac DATE NOT NULL,
    tipo CHAR(1) NOT NULL -- 'H' Honorario, 'T' Técnico Académico
);

CREATE TABLE Proyecto (
    id_proyecto VARCHAR(5) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
	id_equipo_responsable VARCHAR(5) NOT NULL REFERENCES Equipo(id_equipo),
    id_personal_asignado VARCHAR(5) NOT NULL REFERENCES Personal(id_persona)
);

CREATE TABLE Modulo_Capacitacion (
    id_capacitacion SERIAL NOT NULL PRIMARY KEY,
    id_modulo VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Servicio_Social (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Persona(id_persona),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    programa_alterno VARCHAR(100) NOT NULL
);

CREATE TABLE Contacto_Emergencia (
    id_contacto VARCHAR(5) NOT NULL,
    id_persona VARCHAR(5) NOT NULL REFERENCES Persona(id_persona),
    nombre VARCHAR(100) NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    telefono_fijo VARCHAR(15) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono_celular VARCHAR(15) NOT NULL,
    PRIMARY KEY(id_contacto, id_persona)
);

CREATE TABLE Institucion (
    id_institucion SERIAL NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    carrera_afiliada VARCHAR(100) NOT NULL,
    direccion TEXT NOT NULL,
    id_persona VARCHAR(5) NOT NULL REFERENCES Persona(id_persona)
);

CREATE TABLE Padecimiento (
    no_cuenta VARCHAR(9) NOT NULL,
	id_padecimiento VARCHAR(5) NOT NULL,
    descripcion TEXT NOT NULL,
    PRIMARY KEY(no_cuenta, id_padecimiento)
);

CREATE TABLE Estudiante (
    id_persona VARCHAR(5) PRIMARY KEY REFERENCES Persona(id_persona),
    antecedente_DGTIC VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    cvu int NOT NULL,
    escuela VARCHAR(100) NOT NULL,
    semestre INT NOT NULL,
    promedio NUMERIC(3,2) NOT NULL,
    es_becario BOOLEAN NOT NULL,
    no_cuenta VARCHAR(9) REFERENCES Padecimiento(no_cuenta),
	id_padecimiento VARCHAR(5) NOT NULL REFERENCES Padecimiento(id_padecimiento)
);

CREATE TABLE Estudiante (
    id_persona VARCHAR(5) PRIMARY KEY REFERENCES Persona(id_persona),
    antecedente_DGTIC VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    cvu INT NOT NULL,
    escuela VARCHAR(100) NOT NULL,
    semestre INT NOT NULL,
    promedio NUMERIC(3,2) NOT NULL,
    es_becario BOOLEAN NOT NULL,
    no_cuenta VARCHAR(9),
    id_padecimiento VARCHAR(5) NOT NULL,
    FOREIGN KEY (no_cuenta, id_padecimiento) REFERENCES Padecimiento(no_cuenta, id_padecimiento)
);

CREATE TABLE Becario (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Estudiante(id_persona),
    beca VARCHAR(100) NOT NULL,
    trabajo VARCHAR(100) NOT NULL,
    recibe_beca BOOLEAN NOT NULL,
    horario_trabajo VARCHAR(100) NOT NULL
);

CREATE TABLE Datos_Escolares (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Estudiante(id_persona),
    escuela VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    creditos INT NULL NULL,
    semestre INT NOT NULL,
    promedio NUMERIC(3,2) NOT NULL
);

CREATE TABLE Honorario (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Personal(id_persona),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE Tecnico_Academico (
    id_persona VARCHAR(5) NOT NULL PRIMARY KEY REFERENCES Personal(id_persona),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE Asignacion (
    id_asignacion VARCHAR(5) NOT NULL PRIMARY KEY,
    fecha_inicio DATE,
    fecha_fin DATE,
    id_equipo VARCHAR(5) NOT NULL REFERENCES Equipo(id_equipo),
    id_persona VARCHAR(5) NOT NULL REFERENCES Persona(id_persona)
);

CREATE TABLE Periodo (
    id_capacitacion SERIAL NOT NULL REFERENCES Modulo_Capacitacion(id_capacitacion),
    id_periodo SERIAL NOT NULL,
    num_periodo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    PRIMARY KEY(id_capacitacion, id_periodo)
);

CREATE TABLE Capacitacion (
    id_capacitacion SERIAL NOT NULL REFERENCES Modulo_Capacitacion(id_capacitacion),
    id_becario VARCHAR(5) NOT NULL REFERENCES Becario(id_persona),
    PRIMARY KEY(id_capacitacion, id_becario)
);

CREATE OR REPLACE FUNCTION validar_max_contactos()
RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*) FROM Contacto_Emergencia
        WHERE id_persona = NEW.id_persona
    ) >= 2 THEN
        RAISE EXCEPTION 'Un estudiante solo puede tener como máximo 2 contactos de emergencia';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que llama a la función antes del INSERT
CREATE TRIGGER trg_validar_max_contactos
BEFORE INSERT ON Contacto_Emergencia
FOR EACH ROW
EXECUTE FUNCTION validar_max_contactos();

----------- TRIGERS

CREATE OR REPLACE FUNCTION validar_persona_honorario()
RETURNS TRIGGER AS $$
DECLARE
    es_estudiante BOOLEAN;
    becario_activo BOOLEAN;
    ss_activo BOOLEAN;
BEGIN
    -- Verificar si es estudiante
    SELECT tipo_persona = 'E' INTO es_estudiante
    FROM Persona
    WHERE id_persona = NEW.id_persona;

    IF es_estudiante THEN
        RAISE EXCEPTION 'Un estudiante no puede ser registrado como personal honorario';
    END IF;

    -- Verificar si está activo como becario
    SELECT COUNT(*) > 0 INTO becario_activo
    FROM Becario b
    WHERE b.id_persona = NEW.id_persona
      AND b.recibe_beca = TRUE;

    -- Verificar si está activo en servicio social
    SELECT COUNT(*) > 0 INTO ss_activo
    FROM Servicio_Social
    WHERE id_persona = NEW.id_persona
      AND (fecha_fin IS NULL OR fecha_fin > CURRENT_DATE);

    IF becario_activo OR ss_activo THEN
        RAISE EXCEPTION 'No puede registrarse como HONORARIO mientras sea BECARIO o esté en SERVICIO SOCIAL.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_honorario
BEFORE INSERT OR UPDATE ON Honorario
FOR EACH ROW
EXECUTE FUNCTION validar_persona_honorario();
-- VALIDAR TECNICO ACADEMICO

CREATE OR REPLACE FUNCTION validar_tecnico_academico()
RETURNS TRIGGER AS $$
DECLARE
    es_estudiante BOOLEAN;
    honorario_activo BOOLEAN;
BEGIN
    -- Verificar si es estudiante
    SELECT tipo_persona = 'E' INTO es_estudiante
    FROM Persona
    WHERE id_persona = NEW.id_persona;

    IF es_estudiante THEN
        RAISE EXCEPTION 'Un estudiante no puede ser registrado como técnico académico';
    END IF;

    -- Verificar si ya es honorario activo
    SELECT COUNT(*) > 0 INTO honorario_activo
    FROM Honorario
    WHERE id_persona = NEW.id_persona
      AND (fecha_fin IS NULL OR fecha_fin > CURRENT_DATE);

    IF honorario_activo THEN
        RAISE EXCEPTION 'No puede registrarse como TÉCNICO ACADÉMICO mientras esté activo como HONORARIO.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_tecnico_academico
BEFORE INSERT OR UPDATE ON Tecnico_Academico
FOR EACH ROW
EXECUTE FUNCTION validar_tecnico_academico();

---------- vistas ------------------------------
--lista de becarios activos 
CREATE VIEW vista_becarios_activos AS
SELECT 
    b.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    b.beca,
    b.trabajo,
    b.horario_trabajo
FROM Becario b
JOIN Persona p ON p.id_persona = b.id_persona
WHERE b.recibe_beca = TRUE;

----- becarios proximos a terminar un periodo

CREATE OR REPLACE VIEW vista_becarios_proximos_terminar AS
SELECT 
    b.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    e.semestre,
    e.promedio,
    b.beca
FROM Becario b
JOIN Estudiante e ON b.id_persona = e.id_persona
JOIN Persona p ON p.id_persona = b.id_persona
WHERE e.semestre >= 8; 

----- historial completo de una persona por nombre

CREATE OR REPLACE VIEW vista_historial_persona AS
SELECT 
    p.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    'Becario' AS rol,
    b.beca,
    b.trabajo
FROM Persona p
JOIN Becario b ON p.id_persona = b.id_persona

UNION

SELECT 
    p.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    'Servicio Social' AS rol,
    NULL,
    NULL
FROM Persona p
JOIN Servicio_Social s ON p.id_persona = s.id_persona

UNION

SELECT 
    p.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    'Honorario' AS rol,
    NULL,
    NULL
FROM Persona p
JOIN Honorario h ON p.id_persona = h.id_persona

UNION

SELECT 
    p.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    'Técnico Académico' AS rol,
    NULL,
    NULL
FROM Persona p
JOIN Tecnico_Academico t ON p.id_persona = t.id_persona;

----- lista del equipo de un proyecto en particular

CREATE OR REPLACE VIEW vista_equipo_proyecto AS
SELECT 
    pr.id_proyecto,
    pr.nombre AS nombre_proyecto,
    eq.id_equipo,
    eq.nombre AS nombre_equipo,
    pe.id_persona,
    pe.nombre,
    pe.ape_pat,
    pe.ape_mat
FROM Proyecto pr
JOIN Equipo eq ON pr.id_equipo_responsable = eq.id_equipo
JOIN Asignacion a ON eq.id_equipo = a.id_equipo
JOIN Persona pe ON pe.id_persona = a.id_persona;

-- lista completa de becarios con proyectos y fechas

CREATE OR REPLACE VIEW vista_becarios_proyectos AS
SELECT 
    b.id_persona,
    p.nombre,
    p.ape_pat,
    p.ape_mat,
    pr.nombre AS nombre_proyecto,
    pr.fecha_inicio,
    pr.fecha_fin
FROM Becario b
JOIN Persona p ON b.id_persona = p.id_persona
JOIN Asignacion a ON a.id_persona = b.id_persona
JOIN Proyecto pr ON pr.id_equipo_responsable = a.id_equipo;

------------- 8. crear 500 registros de prueba 

-- Insertar 100 direcciones de prueba
DO $$
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Direccion (id_direccion, no_ext, clave_localidad, alcaldia, no_int, clave_municipio, calle, colonia, cp)
        VALUES (
            LPAD(i::text, 5, '0'),
            'EXT' || i,
            'LOC' || i,
            'Alcaldia ' || i,
            'INT' || i,
            'MUN' || i,
            'Calle ' || i,
            'Colonia ' || i,
            'CP' || i
        );
    END LOOP;
END$$;

---- comando para consultar registros 
SELECT COUNT(*) FROM Direccion;

-- Insertar 200 personas (100 estudiantes y 100 personal)
DO $$
BEGIN
    FOR i IN 1..200 LOOP
        INSERT INTO Persona (id_persona, nombre, curp, rfc, ape_pat, ape_mat, tel_fijo, correo, tel_mov, tipo_persona, id_direccion)
        VALUES (
            LPAD(i::text, 5, '0'),
            'Nombre_' || i,
            'CURP' || LPAD(i::text, 14, '0'),
            'RFC' || LPAD(i::text, 10, '0'),
            'ApellidoP_' || i,
            'ApellidoM_' || i,
            '5555' || LPAD(i::text, 6, '0'),
            'persona' || i || '@mail.com',
            '04455' || LPAD(i::text, 6, '0'),
            CASE WHEN i <= 100 THEN 'E' ELSE 'P' END,
            LPAD(((i - 1) % 100 + 1)::text, 5, '0')
        );
    END LOOP;
END$$;

-- Insertar 100 estudiantes

DO $$
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO Padecimiento (no_cuenta, id_padecimiento, descripcion)
        VALUES (
            'NC' || i,
            LPAD(i::text, 5, '0'),
            'Descripción de padecimiento ' || i
        );
    END LOOP;
END$$;

DO $$
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Estudiante (
            id_persona, antecedente_DGTIC, carrera, cvu,
            escuela, semestre, promedio, es_becario, no_cuenta, id_padecimiento
        )
        VALUES (
            LPAD(i::text, 5, '0'),
            'Antecedente ' || i,
            'Carrera ' || i,
            100000 + i,
            'Escuela ' || i,
            (i % 9) + 1,
            ROUND((2.5 + random() * 1.5)::numeric, 2),
            CASE WHEN i <= 70 THEN TRUE ELSE FALSE END,
            'NC' || ((i - 1) % 50 + 1),
            LPAD(((i - 1) % 50 + 1)::text, 5, '0')
        );
    END LOOP;
END$$;

--- servicio social 
DO $$
BEGIN
    FOR i IN 71..100 LOOP
        EXIT WHEN i > 100;
        INSERT INTO Servicio_Social (id_persona, fecha_inicio, fecha_fin, programa_alterno)
        VALUES (
            LPAD(i::text, 5, '0'),
            DATE '2023-01-01' + (i * INTERVAL '3 days'),
            DATE '2023-12-01' + (i * INTERVAL '3 days'),
            'Programa Alterno ' || i
        );
    END LOOP;
END$$;

DO $$
DECLARE
    c INT := 0;
BEGIN
    FOR i IN 1..100 LOOP
        -- Primer contacto
        INSERT INTO Contacto_Emergencia (
            id_contacto, id_persona, nombre, parentesco, telefono_fijo, correo, telefono_celular
        )
        VALUES (
            'C' || i || 'A',
            LPAD(i::text, 5, '0'),
            'Contacto1_' || i,
            'Padre',
            '555123' || i,
            'contacto1_' || i || '@mail.com',
            '04455' || i || '1'
        );

        -- Segundo contacto (solo si no supera 150)
        c := c + 2;
        EXIT WHEN c > 150;

        INSERT INTO Contacto_Emergencia (
            id_contacto, id_persona, nombre, parentesco, telefono_fijo, correo, telefono_celular
        )
        VALUES (
            'C' || i || 'B',
            LPAD(i::text, 5, '0'),
            'Contacto2_' || i,
            'Madre',
            '555456' || i,
            'contacto2_' || i || '@mail.com',
            '04455' || i || '2'
        );
    END LOOP;
END$$;

---- 
DO $$
BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO Equipo (id_equipo, nombre, fecha_creacion)
        VALUES (
            LPAD(i::text, 5, '0'),
            'Equipo_' || i,
            DATE '2022-01-01' + (i * INTERVAL '15 days')
        );
    END LOOP;
END$$;

---- proyecto 30 registros 

DO $$
BEGIN
    FOR i IN 1..30 LOOP
        INSERT INTO Proyecto (id_proyecto, nombre, fecha_inicio, fecha_fin, id_equipo_responsable, id_personal_asignado)
        VALUES (
            LPAD(i::text, 5, '0'),
            'Proyecto_' || i,
            DATE '2023-01-01' + (i * INTERVAL '10 days'),
            DATE '2024-01-01' + (i * INTERVAL '10 days'),
            LPAD(((i - 1) % 20 + 1)::text, 5, '0'),
            LPAD(((i - 1) % 50 + 101)::text, 5, '0') -- personal del 101 al 150
        );
    END LOOP;
END$$;

DO $$
BEGIN
    FOR i IN 101..150 LOOP
        INSERT INTO Personal (id_persona, fecha_nac, tipo)
        VALUES (
            LPAD(i::text, 5, '0'),
            DATE '1980-01-01' + (i * INTERVAL '10 days'),
            CASE WHEN i <= 125 THEN 'H' ELSE 'T' END
        );
    END LOOP;
END$$;

--- proyecto
DO $$
BEGIN
    FOR i IN 1..30 LOOP
        INSERT INTO Proyecto (id_proyecto, nombre, fecha_inicio, fecha_fin, id_equipo_responsable, id_personal_asignado)
        VALUES (
            LPAD(i::text, 5, '0'),
            'Proyecto_' || i,
            DATE '2023-01-01' + (i * INTERVAL '10 days'),
            DATE '2024-01-01' + (i * INTERVAL '10 days'),
            LPAD(((i - 1) % 20 + 1)::text, 5, '0'),      -- 20 equipos
            LPAD(((i - 1) % 50 + 101)::text, 5, '0')     -- personal del 101 al 150
        );
    END LOOP;
END$$;

--- institucion 15 registros a personas existentes
DO $$
BEGIN
    FOR i IN 1..15 LOOP
        INSERT INTO Institucion (nombre, telefono, carrera_afiliada, direccion, id_persona)
        VALUES (
            'Institución ' || i,
            '555100' || i,
            'Carrera Afiliada ' || i,
            'Dirección completa de institución ' || i,
            LPAD(((i - 1) % 200 + 1)::text, 5, '0')
        );
    END LOOP;
END$$;

---- modulo capacitacion 10 registros
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO Modulo_Capacitacion (id_modulo, descripcion, nombre)
        VALUES (
            'MOD' || i,
            'Descripción del módulo ' || i,
            'Módulo ' || i
        );
    END LOOP;
END$$;

----- 15 registros 1 a 3 por cada capacitacion
DO $$
DECLARE
    pid INT := 1;
BEGIN
    FOR i IN 1..5 LOOP
        FOR j IN 1..3 LOOP
            INSERT INTO Periodo (id_capacitacion, id_periodo, num_periodo, fecha_inicio, fecha_fin)
            VALUES (
                i,
                pid,
                j,
                DATE '2023-01-01' + (pid * INTERVAL '20 days'),
                DATE '2023-01-30' + (pid * INTERVAL '20 days')
            );
            pid := pid + 1;
        END LOOP;
    END LOOP;
END$$;

---- capaitacion 50 registros vinculados becarios y módulos
DO $$
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO Capacitacion (id_capacitacion, id_becario)
        VALUES (
            ((i - 1) % 10 + 1),      -- ID de módulo (1 a 10)
            LPAD(((i - 1) % 70 + 1)::text, 5, '0')  -- ID de becario (1 a 70)
        );
    END LOOP;
END$$;

SELECT COUNT(*) FROM Becario;

DO $$
BEGIN
    FOR i IN 1..70 LOOP
        INSERT INTO Becario (id_persona, beca, trabajo, recibe_beca, horario_trabajo)
        VALUES (
            LPAD(i::text, 5, '0'),
            'Beca ' || i,
            'Trabajo ' || i,
            TRUE,
            'L-V 9:00-14:00'
        );
    END LOOP;
END$$;

DO $$
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO Capacitacion (id_capacitacion, id_becario)
        VALUES (
            ((i - 1) % 10 + 1),                -- módulo 1 a 10
            LPAD(((i - 1) % 70 + 1)::text, 5, '0')  -- becario 00001 a 00070
        );
    END LOOP;
END$$;

-- pruebas 
-- Verificar cantidad por tabla
SELECT COUNT(*) FROM Direccion;
SELECT COUNT(*) FROM Persona;
SELECT COUNT(*) FROM Estudiante;
SELECT COUNT(*) FROM Becario;
SELECT COUNT(*) FROM Proyecto;
-- etc.

SELECT * FROM Persona;
SELECT * FROM Estudiante;
SELECT * FROM Proyecto;

------------ evaluación de las vistas

SELECT * FROM vista_becarios_activos;
-- devuelve tiempo total de la ejecución, total de operaciones, uso de índices 
EXPLAIN ANALYZE SELECT * FROM vista_becarios_activos;

EXPLAIN ANALYZE SELECT * FROM vista_becarios_proximos_terminar;

EXPLAIN ANALYZE SELECT * FROM vista_historial_persona;

----
EXPLAIN ANALYZE SELECT * FROM vista_equipo_proyecto;
---
EXPLAIN ANALYZE SELECT * FROM vista_becarios_proyectos;
----Realice un cambio en su diseño lógico para reducir el tiempo de respuesta en la construcción
--- de las vistas consideradas

DROP VIEW IF EXISTS vista_becarios_proyectos;

CREATE OR REPLACE VIEW vista_becarios_proyectos AS
SELECT b.no_cuenta, b.nombre AS nombre_becario, b.apellido_paterno, b.apellido_materno,
       p.nombre_proyecto, p.clave_proyecto, i.nombre AS institucion
FROM becario b
JOIN proyecto p ON b.clave_proyecto = p.clave_proyecto
JOIN institucion i ON p.clave_institucion = i.clave_institucion;