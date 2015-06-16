-- Integridad referencial de idDirector en Hotel con respecto a Empleado --
CREATE OR REPLACE TRIGGER referenciaDirector
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
  numEmpleados NUMBER;
BEGIN
  IF :NEW.idDirector IS NOT NULL THEN
	  SELECT COUNT(*) INTO numEmpleados FROM empleado
	  WHERE empleado.idEmpleado = :NEW.idDirector;

	  IF numEmpleados = 0 THEN
	      RAISE_APPLICATION_ERROR(-20300,'Error de integridad referencial: el director especificado no existe en la base de datos');
	  END IF;
   END IF;
END;
/

-- Integridad referencial de idHotel en Suministro con respecto Hotel --
CREATE OR REPLACE TRIGGER referenciaHotel
BEFORE INSERT OR UPDATE ON fragmentoSuministro
FOR EACH ROW
DECLARE
numHoteles NUMBER;
BEGIN
   IF :NEW.idHotel IS NOT NULL THEN
      SELECT COUNT(*) INTO numHoteles FROM hotel
      WHERE hotel.idHotel = :NEW.idHotel;

      IF numHoteles = 0 THEN
         RAISE_APPLICATION_ERROR(-20301,'Error de integridad referencial: el hotel especificado no existe en la base de datos');
      END IF;
   END IF;
END;
/
