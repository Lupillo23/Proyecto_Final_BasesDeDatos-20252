CREATE OR REPLACE FUNCTION validar_tecnico_academico_sin_honorarios()
RETURNS TRIGGER AS $$
DECLARE
    honorario_activo BOOLEAN;
BEGIN
    -- Verificar si la persona está actualmente como honorario activo
    SELECT EXISTS (
        SELECT 1 
        FROM Honorario 
        WHERE id_persona = NEW.id_persona
        AND (fecha_fin IS NULL OR fecha_fin > CURRENT_DATE)
    ) INTO honorario_activo;

    -- Si está activo como honorario, mostrar error
    IF honorario_activo THEN
        RAISE EXCEPTION 
            'No se puede registrar como técnico académico. La persona % todavía está activa como personal de honorarios. '
            'Debe terminar su contrato como honorario primero.', 
            (SELECT nombre || ' ' || ape_pat FROM Persona WHERE id_persona = NEW.id_persona);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que se activa antes de insertar o actualizar
CREATE TRIGGER trg_validar_tecnico_sin_honorarios
BEFORE INSERT OR UPDATE ON Tecnico_Academico
FOR EACH ROW
EXECUTE FUNCTION validar_tecnico_academico_sin_honorarios();