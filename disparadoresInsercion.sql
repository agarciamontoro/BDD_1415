
-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaEmpleado
BEFORE INSERT OR UPDATE ON fragmentoEmpleado
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idEmpleado')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Empleado
     WHERE idEmpleado = :NEW.idEmpleado;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20200,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaHotel
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel')) THEN
    SELECT COUNT(*) INTO numTuplas FROM Hotel
    WHERE idHotel = :NEW.idHotel;
  	IF numTuplas > 0 THEN
    	RAISE_APPLICATION_ERROR(-20201,'Restricción de llave única violada: la llave ya existe en la tabla');
    END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTrabaja
BEFORE INSERT OR UPDATE ON fragmentoTrabaja
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel') OR UPDATING('idEmpleado')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Trabaja
     WHERE idEmpleado = :NEW.idEmpleado;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20202,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaReserva
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idCliente') OR UPDATING('fechaEntrada') OR UPDATING ('fechaSalida')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Reserva
     WHERE idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20203,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/
-- Solo para magnos2 - Granada y magnos4 - Sevilla

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaProveedor
BEFORE INSERT OR UPDATE ON fragmentoProveedor
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idProveedor')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Proveedor
     WHERE idProveedor = :NEW.idProveedor;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20204,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTiene
BEFORE INSERT OR UPDATE ON fragmentoTiene
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idArticulo') OR UPDATING('idProveedor')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Tiene
     WHERE idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20205,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaSuministro
BEFORE INSERT OR UPDATE ON fragmentoSuministro
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel') OR UPDATING('fecha') OR UPDATING('idProveedor') OR UPDATING('idArticulo')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Suministro
     WHERE idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20206,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

COMMIT;
