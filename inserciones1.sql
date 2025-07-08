BEGIN;
-- Todas las inserciones aquí
-- 1. Insertar direcciones
INSERT INTO Direccion (id_direccion, no_ext, clave_localidad, alcaldia, no_int, clave_municipio, calle, colonia, cp)
VALUES 
('D0001', '123', 'LOC001', 'Álvaro Obregón', 'A', 'MUN001', 'Av. Revolución', 'San Ángel', '01000'),
('D0002', '456', 'LOC002', 'Coyoacán', 'B', 'MUN002', 'Av. Universidad', 'Copilco', '04360'),
('D0003', '789', 'LOC003', 'Cuajimalpa', 'C', 'MUN003', 'Av. Constituyentes', 'Lomas de Vista Hermosa', '05100'),
('D0004', '101', 'LOC004', 'Miguel Hidalgo', 'D', 'MUN004', 'Paseo de la Reforma', 'Lomas de Chapultepec', '11000'),
('D0005', '202', 'LOC005', 'Benito Juárez', 'E', 'MUN005', 'Av. Insurgentes', 'Del Valle', '03100');

-- 2. Insertar personas (15 estudiantes y 10 personal)
INSERT INTO Persona (id_persona, nombre, curp, rfc, ape_pat, ape_mat, tel_fijo, correo, tel_mov, tipo_persona, id_direccion)
VALUES
-- Estudiantes (tipo 'E')
('P1000', 'Juan Pérez López', 'PELJ920101HDFRNN01', 'PELJ920101ABC', 'Pérez', 'López', '5555123456', 'juan.perez@email.com', '5555123457', 'E', 'D0001'),
('P0002', 'María García Rodríguez', 'GARM920202MDFRNN02', 'GARM920202ABC', 'García', 'Rodríguez', '5555223456', 'maria.garcia@email.com', '5555223457', 'E', 'D0002'),
('P0003', 'Carlos Martínez Sánchez', 'MASC920303HDFRNN03', 'MASC920303ABC', 'Martínez', 'Sánchez', '5555323456', 'carlos.martinez@email.com', '5555323457', 'E', 'D0003'),
('P0004', 'Ana López Hernández', 'LOHA920404MDFRNN04', 'LOHA920404ABC', 'López', 'Hernández', '5555423456', 'ana.lopez@email.com', '5555423457', 'E', 'D0004'),
('P0005', 'José González Ramírez', 'GORJ920505HDFRNN05', 'GORJ920505ABC', 'González', 'Ramírez', '5555523456', 'jose.gonzalez@email.com', '5555523457', 'E', 'D0005'),
('P0006', 'Laura Díaz Flores', 'DIFL920606MDFRNN06', 'DIFL920606ABC', 'Díaz', 'Flores', '5555623456', 'laura.diaz@email.com', '5555623457', 'E', 'D0001'),
('P0007', 'Miguel Ruiz Castro', 'RUCM920707HDFRNN07', 'RUCM920707ABC', 'Ruiz', 'Castro', '5555723456', 'miguel.ruiz@email.com', '5555723457', 'E', 'D0002'),
('P0008', 'Sofía Medina Ortega', 'MEOS920808MDFRNN08', 'MEOS920808ABC', 'Medina', 'Ortega', '5555823456', 'sofia.medina@email.com', '5555823457', 'E', 'D0003'),
('P0009', 'Jorge Silva Mendoza', 'SIMJ920909HDFRNN09', 'SIMJ920909ABC', 'Silva', 'Mendoza', '5555923456', 'jorge.silva@email.com', '5555923457', 'E', 'D0004'),
('P0010', 'Patricia Vargas Ríos', 'VARP921010MDFRNN10', 'VARP921010ABC', 'Vargas', 'Ríos', '5555023456', 'patricia.vargas@email.com', '5555023457', 'E', 'D0005'),
('P0011', 'Fernando Castro Núñez', 'CANF921111HDFRNN11', 'CANF921111ABC', 'Castro', 'Núñez', '5555134567', 'fernando.castro@email.com', '5555134568', 'E', 'D0001'),
('P0012', 'Adriana Ortega Jiménez', 'ORJA921212MDFRNN12', 'ORJA921212ABC', 'Ortega', 'Jiménez', '5555234567', 'adriana.ortega@email.com', '5555234568', 'E', 'D0002'),
('P0013', 'Ricardo Mendoza Paredes', 'MEPR930101HDFRNN13', 'MEPR930101ABC', 'Mendoza', 'Paredes', '5555334567', 'ricardo.mendoza@email.com', '5555334568', 'E', 'D0003'),
('P0014', 'Gabriela Ríos Soto', 'RISG930202MDFRNN14', 'RISG930202ABC', 'Ríos', 'Soto', '5555434567', 'gabriela.rios@email.com', '5555434568', 'E', 'D0004'),
('P0015', 'Roberto Núñez Vega', 'NUVR930303HDFRNN15', 'NUVR930303ABC', 'Núñez', 'Vega', '5555534567', 'roberto.nunez@email.com', '5555534568', 'E', 'D0005'),
-- Personal (tipo 'P')
('P0016', 'Alejandro Jiménez Guerrero', 'JIGA940404HDFRNN16', 'JIGA940404ABC', 'Jiménez', 'Guerrero', '5555634567', 'alejandro.jimenez@email.com', '5555634568', 'P', 'D0001'),
('P0017', 'Claudia Paredes Moreno', 'PAMC940505MDFRNN17', 'PAMC940505ABC', 'Paredes', 'Moreno', '5555734567', 'claudia.paredes@email.com', '5555734568', 'P', 'D0002'),
('P0018', 'Arturo Soto Rangel', 'SORA940606HDFRNN18', 'SORA940606ABC', 'Soto', 'Rangel', '5555834567', 'arturo.soto@email.com', '5555834568', 'P', 'D0003'),
('P0019', 'Verónica Vega Campos', 'VECV940707MDFRNN19', 'VECV940707ABC', 'Vega', 'Campos', '5555934567', 'veronica.vega@email.com', '5555934568', 'P', 'D0004'),
('P0020', 'Raúl Guerrero Orozco', 'GUOR940808HDFRNN20', 'GUOR940808ABC', 'Guerrero', 'Orozco', '5555034567', 'raul.guerrero@email.com', '5555034568', 'P', 'D0005'),
('P0021', 'Diana Moreno Cervantes', 'MOCD940909MDFRNN21', 'MOCD940909ABC', 'Moreno', 'Cervantes', '5555145678', 'diana.moreno@email.com', '5555145679', 'P', 'D0001'),
('P0022', 'Oscar Rangel Fuentes', 'RAFO941010HDFRNN22', 'RAFO941010ABC', 'Rangel', 'Fuentes', '5555245678', 'oscar.rangel@email.com', '5555245679', 'P', 'D0002'),
('P0023', 'Lucía Campos Salinas', 'CASL941111MDFRNN23', 'CASL941111ABC', 'Campos', 'Salinas', '5555345678', 'lucia.campos@email.com', '5555345679', 'P', 'D0003'),
('P0024', 'Francisco Orozco Méndez', 'ORMF941212HDFRNN24', 'ORMF941212ABC', 'Orozco', 'Méndez', '5555445678', 'francisco.orozco@email.com', '5555445679', 'P', 'D0004'),
('P0025', 'Teresa Cervantes León', 'CELT950101MDFRNN25', 'CELT950101ABC', 'Cervantes', 'León', '5555545678', 'teresa.cervantes@email.com', '5555545679', 'P', 'D0005');

-- 3. Insertar padecimientos
INSERT INTO Padecimiento (no_cuenta, id_padecimiento, descripcion)
VALUES
('123456789', 'PD001', 'Ningún padecimiento'),
('234567890', 'PD002', 'Alergias estacionales'),
('345678901', 'PD003', 'Asma controlada'),
('456789012', 'PD004', 'Hipertensión'),
('567890123', 'PD005', 'Diabetes tipo 1'),
('678901234', 'PD006', 'Migrañas ocasionales'),
('789012345', 'PD007', 'Problemas de visión'),
('890123456', 'PD008', 'Dolor crónico de espalda'),
('901234567', 'PD009', 'Intolerancia a la lactosa'),
('012345678', 'PD010', 'Problemas de tiroides'),
('112233445', 'PD011', 'Depresión leve'),
('223344556', 'PD012', 'Ansiedad controlada'),
('334455667', 'PD013', 'Artritis'),
('445566778', 'PD014', 'Problemas digestivos'),
('556677889', 'PD015', 'Insomnio ocasional');

-- 4. Insertar estudiantes
INSERT INTO Estudiante (id_persona, antecedente_DGTIC, carrera, cvu, escuela, semestre, promedio, es_becario, no_cuenta, id_padecimiento)
VALUES
('P0001', 'Bachillerato UNAM', 'Ingeniería en Computación', 123456, 'Facultad de Ingeniería', 5, 8.5, TRUE, '123456789', 'PD001'),
('P0002', 'CCH Sur', 'Ciencias de la Computación', 234567, 'Facultad de Ciencias', 3, 9.0, TRUE, '234567890', 'PD002'),
('P0003', 'Prepa 2', 'Informática', 345678, 'Facultad de Contaduría', 2, 8.0, FALSE, '345678901', 'PD003'),
('P0004', 'Bachillerato IPN', 'Ingeniería en Computación', 456789, 'ESIME Zacatenco', 6, 9.2, TRUE, '456789012', 'PD004'),
('P0005', 'CCH Oriente', 'Ciencias de la Computación', 567890, 'Facultad de Ciencias', 4, 8.7, TRUE, '567890123', 'PD005'),
('P0006', 'Prepa 6', 'Informática', 678901, 'Facultad de Contaduría', 1, 7.5, FALSE, '678901234', 'PD006'),
('P0007', 'Bachillerato UNAM', 'Ingeniería en Computación', 789012, 'Facultad de Ingeniería', 7, 9.5, TRUE, '789012345', 'PD007'),
('P0008', 'CCH Vallejo', 'Ciencias de la Computación', 890123, 'Facultad de Ciencias', 5, 8.9, TRUE, '890123456', 'PD008'),
('P0009', 'Prepa 9', 'Informática', 901234, 'Facultad de Contaduría', 3, 8.2, FALSE, '901234567', 'PD009'),
('P0010', 'Bachillerato IPN', 'Ingeniería en Computación', 123457, 'ESIME Zacatenco', 8, 9.1, TRUE, '012345678', 'PD010'),
('P0011', 'CCH Sur', 'Ciencias de la Computación', 234568, 'Facultad de Ciencias', 6, 8.8, TRUE, '112233445', 'PD011'),
('P0012', 'Prepa 5', 'Informática', 345679, 'Facultad de Contaduría', 4, 7.9, FALSE, '223344556', 'PD012'),
('P0013', 'Bachillerato UNAM', 'Ingeniería en Computación', 456780, 'Facultad de Ingeniería', 2, 8.3, FALSE, '334455667', 'PD013'),
('P0014', 'CCH Oriente', 'Ciencias de la Computación', 567891, 'Facultad de Ciencias', 3, 9.3, TRUE, '445566778', 'PD014'),
('P0015', 'Prepa 3', 'Informática', 678902, 'Facultad de Contaduría', 5, 8.1, FALSE, '556677889', 'PD015');

-- 5. Insertar becarios (solo los estudiantes con es_becario = TRUE)
INSERT INTO Becario (id_persona, beca, trabajo, recibe_beca, horario_trabajo)
VALUES
('P0001', 'Manutención', 'Desarrollo web', TRUE, 'Lunes a Viernes 9-14'),
('P0002', 'Excelencia académica', 'Investigación', TRUE, 'Lunes a Jueves 10-14'),
('P0004', 'Manutención', 'Base de datos', TRUE, 'Martes y Jueves 15-19'),
('P0005', 'Excelencia académica', 'Análisis de datos', TRUE, 'Lunes a Viernes 10-12'),
('P0007', 'Manutención', 'Desarrollo móvil', TRUE, 'Miércoles y Viernes 14-18'),
('P0008', 'Excelencia académica', 'Inteligencia Artificial', TRUE, 'Lunes a Jueves 9-13'),
('P0010', 'Manutención', 'Seguridad informática', TRUE, 'Viernes 8-16'),
('P0011', 'Excelencia académica', 'Machine Learning', TRUE, 'Lunes y Miércoles 15-19'),
('P0014', 'Manutención', 'Cloud Computing', TRUE, 'Martes a Jueves 10-14');

-- 6. Insertar datos escolares
INSERT INTO Datos_Escolares (id_persona, escuela, carrera, creditos, semestre, promedio)
SELECT id_persona, escuela, carrera, 
       CASE 
           WHEN semestre = 1 THEN 30
           WHEN semestre = 2 THEN 60
           WHEN semestre = 3 THEN 90
           WHEN semestre = 4 THEN 120
           WHEN semestre = 5 THEN 150
           WHEN semestre = 6 THEN 180
           WHEN semestre = 7 THEN 210
           WHEN semestre = 8 THEN 240
       END,
       semestre, promedio
FROM Estudiante;

-- 7. Insertar contactos de emergencia (máximo 2 por persona)
INSERT INTO Contacto_Emergencia (id_contacto, id_persona, nombre, parentesco, telefono_fijo, correo, telefono_celular)
VALUES
-- Contactos para estudiantes
('CE001', 'P0001', 'Laura Pérez López', 'Madre', '5555123458', 'laura.perez@email.com', '5555123459'),
('CE002', 'P0001', 'Pedro López Gómez', 'Padre', '5555123460', 'pedro.lopez@email.com', '5555123461'),
('CE003', 'P0002', 'Carmen García Martínez', 'Madre', '5555223458', 'carmen.garcia@email.com', '5555223459'),
('CE004', 'P0003', 'Jorge Martínez Fernández', 'Padre', '5555323458', 'jorge.martinez@email.com', '5555323459'),
('CE005', 'P0004', 'Isabel Sánchez Ruiz', 'Madre', '5555423458', 'isabel.sanchez@email.com', '5555423459'),
('CE006', 'P0005', 'Ricardo González Castro', 'Padre', '5555523458', 'ricardo.gonzalez@email.com', '5555523459'),
('CE007', 'P0006', 'Adriana Díaz Méndez', 'Madre', '5555623458', 'adriana.diaz@email.com', '5555623459'),
('CE008', 'P0007', 'Fernando Ruiz Ortega', 'Padre', '5555723458', 'fernando.ruiz@email.com', '5555723459'),
('CE009', 'P0008', 'Patricia Medina Vargas', 'Madre', '5555823458', 'patricia.medina@email.com', '5555823459'),
('CE010', 'P0009', 'Roberto Silva Núñez', 'Padre', '5555923458', 'roberto.silva@email.com', '5555923459'),
-- Contactos para personal
('CE011', 'P0016', 'Guadalupe Jiménez Torres', 'Esposa', '5555634568', 'guadalupe.jimenez@email.com', '5555634569'),
('CE012', 'P0017', 'Alejandro Paredes Ríos', 'Esposo', '5555734568', 'alejandro.paredes@email.com', '5555734569'),
('CE013', 'P0018', 'María Soto Vega', 'Esposa', '5555834568', 'maria.soto@email.com', '5555834569'),
('CE014', 'P0019', 'Javier Vega Campos', 'Esposo', '5555934568', 'javier.vega@email.com', '5555934569'),
('CE015', 'P0020', 'Lucía Guerrero Moreno', 'Esposa', '5555034568', 'lucia.guerrero@email.com', '5555034569');

-- 8. Insertar personal
INSERT INTO Personal (id_persona, fecha_nac, tipo)
VALUES
('P0016', '1980-05-15', 'H'),
('P0017', '1985-08-20', 'T'),
('P0018', '1978-11-30', 'H'),
('P0019', '1982-03-25', 'T'),
('P0020', '1975-09-10', 'H'),
('P0021', '1988-12-05', 'T'),
('P0022', '1983-07-18', 'H'),
('P0023', '1979-04-22', 'T'),
('P0024', '1986-10-15', 'H'),
('P0025', '1981-01-28', 'T');

-- 9. Insertar honorarios
INSERT INTO Honorario (id_persona, fecha_inicio, fecha_fin)
VALUES
('P0016', '2020-01-10', '2023-12-31'),
('P0018', '2021-03-15', '2024-06-30'),
('P0020', '2019-05-20', '2023-08-15'),
('P0022', '2022-02-01', '2024-02-01'),
('P0024', '2021-09-12', '2023-11-30');

-- 10. Insertar técnicos académicos
INSERT INTO Tecnico_Academico (id_persona, fecha_inicio, fecha_fin)
VALUES
('P0017', '2018-06-01', '2025-06-01'),
('P0019', '2019-08-15', '2024-08-15'),
('P0021', '2020-11-01', '2023-11-01'),
('P0023', '2021-04-10', '2026-04-10'),
('P0025', '2017-03-20', '2025-03-20');

-- 11. Insertar servicio social
INSERT INTO Servicio_Social (id_persona, fecha_inicio, fecha_fin, programa_alterno)
VALUES
('P0003', '2023-01-15', '2023-07-15', 'Programa de apoyo comunitario'),
('P0006', '2023-02-01', '2023-08-01', 'Programa de desarrollo tecnológico'),
('P0009', '2023-03-10', '2023-09-10', 'Programa de educación digital'),
('P0012', '2023-04-05', '2023-10-05', 'Programa de investigación social'),
('P0015', '2023-05-20', '2023-11-20', 'Programa de sustentabilidad');

-- 12. Insertar equipos
INSERT INTO Equipo (id_equipo, nombre, fecha_creacion)
VALUES
('EQ001', 'Desarrollo de Software', '2020-01-15'),
('EQ002', 'Investigación en IA', '2021-03-10'),
('EQ003', 'Base de Datos', '2019-05-20'),
('EQ004', 'Seguridad Informática', '2022-02-01'),
('EQ005', 'Cloud Computing', '2021-07-12');

-- 13. Insertar proyectos
INSERT INTO Proyecto (id_proyecto, nombre, fecha_inicio, fecha_fin, id_equipo_responsable, id_personal_asignado)
VALUES
('PR001', 'Sistema de Gestión Escolar', '2023-01-01', '2023-12-31', 'EQ001', 'P0017'),
('PR002', 'Chatbot Inteligente', '2023-03-01', '2024-03-01', 'EQ002', 'P0019'),
('PR003', 'Migración a Base de Datos NoSQL', '2023-02-15', '2023-08-15', 'EQ003', 'P0021'),
('PR004', 'Auditoría de Seguridad', '2023-04-01', '2023-10-01', 'EQ004', 'P0023'),
('PR005', 'Plataforma en la Nube', '2023-05-15', '2024-05-15', 'EQ005', 'P0025');

-- 14. Insertar asignaciones
INSERT INTO Asignacion (id_asignacion, fecha_inicio, fecha_fin, id_equipo, id_persona)
VALUES
('AS001', '2023-01-15', NULL, 'EQ001', 'P0001'),
('AS002', '2023-02-01', NULL, 'EQ001', 'P0016'),
('AS003', '2023-03-10', '2023-09-10', 'EQ002', 'P0002'),
('AS004', '2023-04-05', NULL, 'EQ002', 'P0018'),
('AS005', '2023-05-20', NULL, 'EQ003', 'P0004'),
('AS006', '2023-06-15', NULL, 'EQ003', 'P0020'),
('AS007', '2023-07-01', '2023-12-31', 'EQ004', 'P0007'),
('AS008', '2023-08-10', NULL, 'EQ004', 'P0022'),
('AS009', '2023-09-05', NULL, 'EQ005', 'P0010'),
('AS010', '2023-10-20', NULL, 'EQ005', 'P0024');

-- 15. Insertar instituciones
INSERT INTO Institucion (nombre, telefono, carrera_afiliada, direccion, id_persona)
VALUES
('UNAM', '55556220000', 'Ingeniería en Computación', 'Ciudad Universitaria, CDMX', 'P0016'),
('IPN', '55557280000', 'Ciencias de la Computación', 'Av. Luis Enrique Erro S/N, CDMX', 'P0017'),
('Tec de Monterrey', '55558123456', 'Informática', 'Av. Carlos Lazo 100, CDMX', 'P0018'),
('Universidad Anáhuac', '55558234567', 'Ingeniería en Computación', 'Av. Universidad Anáhuac 46, CDMX', 'P0019'),
('Universidad Iberoamericana', '55558345678', 'Ciencias de la Computación', 'Prol. Paseo de la Reforma 880, CDMX', 'P0020');

-- 16. Insertar módulos de capacitación
INSERT INTO Modulo_Capacitacion (id_modulo, descripcion, nombre)
VALUES
('MOD001', 'Capacitación en desarrollo web', 'Desarrollo Web'),
('MOD002', 'Capacitación en bases de datos', 'Bases de Datos'),
('MOD003', 'Capacitación en inteligencia artificial', 'Inteligencia Artificial'),
('MOD004', 'Capacitación en seguridad informática', 'Seguridad Informática'),
('MOD005', 'Capacitación en cloud computing', 'Cloud Computing');

-- 17. Insertar periodos de capacitación
INSERT INTO Periodo (id_capacitacion, num_periodo, fecha_inicio, fecha_fin)
VALUES
(1, 1, '2023-01-10', '2023-03-10'),
(1, 2, '2023-04-10', '2023-06-10'),
(2, 1, '2023-02-15', '2023-05-15'),
(3, 1, '2023-03-01', '2023-06-01'),
(4, 1, '2023-04-05', '2023-07-05'),
(5, 1, '2023-05-20', '2023-08-20');

-- 18. Insertar capacitaciones para becarios
INSERT INTO Capacitacion (id_capacitacion, id_becario)
VALUES
(1, 'P0001'),
(2, 'P0002'),
(3, 'P0004'),
(4, 'P0005'),
(5, 'P0007'),
(1, 'P0008'),
(2, 'P0010'),
(3, 'P0011'),
(4, 'P0014');

COMMIT;