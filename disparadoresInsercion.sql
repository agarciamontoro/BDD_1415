
-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica 
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM cliente
  WHERE idCliente = :NEW.idCliente;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10001,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON empleado
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM empleado
  WHERE idEmpleado = :NEW.idCliente;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10002,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON hotel
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM hotel
  WHERE idHotel = :NEW.idHotel;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10003,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON trabaja
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM trabaja
  WHERE idEmpleado = :NEW.idEmpleado;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10004,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON reserva
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM reserva
  WHERE idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10005,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON proveedor
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM proveedor
  WHERE idProveedor = :NEW.idProveedor;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10006,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON articulo
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM articulo
  WHERE idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10007,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON tiene
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM tiene
  WHERE idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10008,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;

-------------------------------------------------------

CREATE OR REPLACE TRIGGER restriccionLlaveUnica
BEFORE INSERT OR UPDATE ON suministro
FOR EACH ROW
DECLARE
  numTuplas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numTuplas FROM suministro
  WHERE idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
	IF numTuplas > 0 THEN
  	RAISE_APPLICATION_ERROR(-10009,'Restricción de llave única violada: la llave ya existe en la tabla');
  END IF;
END;
