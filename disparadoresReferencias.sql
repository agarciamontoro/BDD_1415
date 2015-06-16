-- Integridad referencial de idDirector en Hotel con respecto a Empleado --
CREATE OR REPLACE TRIGGER referenciaDirector
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
  numEmpleados NUMBER;
BEGIN
  SELECT COUNT(*) INTO numEmpleados FROM empleado
  WHERE empleado.idEmpleado = :NEW.idDirector;

  IF numEmpleados = 0 THEN
      RAISE_APPLICATION_ERROR(-31001,'Error de integridad referencial: el director especificado no existe en la base de datos');
  END IF;

END;
/