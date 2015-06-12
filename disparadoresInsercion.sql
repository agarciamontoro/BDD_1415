
-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaCliente
BEFORE INSERT OR UPDATE ON Cliente
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Cliente
  WHERE idCliente = :NEW.idCliente;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10000,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaEmpleado
BEFORE INSERT OR UPDATE ON fragmentoEmpleado
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Empleado
  WHERE idEmpleado = :NEW.idEmpleado;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10001,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaHotel
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Hotel
  WHERE idHotel = :NEW.idHotel;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10002,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTrabaja
BEFORE INSERT OR UPDATE ON fragmentoTrabaja
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Trabaja
  WHERE idEmpleado = :NEW.idEmpleado;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10003,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaReserva
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Reserva
  WHERE idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10004,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/
/* Solo para magnos2 - Granada y magnos4 - Sevilla

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaProveedor
BEFORE INSERT OR UPDATE ON fragmentoProveedor
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Proveedor
  WHERE idProveedor = :NEW.idProveedor;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10005,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaArticulo
BEFORE INSERT OR UPDATE ON Articulo
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Articulo
  WHERE idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10006,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTiene
BEFORE INSERT OR UPDATE ON fragmentoTiene
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Tiene
  WHERE idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10007,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaSuministro
BEFORE INSERT OR UPDATE ON fragmentoSuministro
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Suministro
  WHERE idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10008,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
/
*/
