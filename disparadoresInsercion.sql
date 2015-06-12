
-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaCliente
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaEmpleado
BEFORE INSERT OR UPDATE ON Empleado
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM Empleado
  WHERE idEmpleado = :NEW.idCliente;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10001,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaHotel
BEFORE INSERT OR UPDATE ON Hotel
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaTrabaja
BEFORE INSERT OR UPDATE ON Trabaja
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaReserva
BEFORE INSERT OR UPDATE ON Reserva
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaProveedor
BEFORE INSERT OR UPDATE ON Proveedor
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaArticulo
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaTiene
BEFORE INSERT OR UPDATE ON Tiene
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

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnicaSuministro
BEFORE INSERT OR UPDATE ON Suministro
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
