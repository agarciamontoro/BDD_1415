-- Restricción 4 --
-- Antes de hacer una nueva reserva contamos el número de reservas que tenemos del tipo de
-- habitacion que queremos insertar. A continuación vemos cuantas habitaciones tiene el
-- hotel del tipo que se quiere añadir una reserva, y en el caso en el que el número de
-- habitaciones de ese tipo sea menor o igual que el número de reservas que se tiene
-- actualmente, lanzamos error, en caso contrario, dejamos que se haga la inserción

CREATE OR REPLACE TRIGGER capacidadReservas
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
  habSimples NUMBER;
  habDobles  NUMBER;
  reservasActuales NUMBER;
BEGIN
  SELECT COUNT(*) INTO reservasActuales FROM reserva, hotel
  WHERE reserva.idHotel = :NEW.idHotel
    AND reserva.tipoHabitacion = :NEW.tipoHabitacion;

  IF :NEW.tipoHabitacion = 'Simple' THEN
    SELECT sencillasLibres INTO habSimples FROM hotel
    WHERE hotel.idHotel = :NEW.idHotel;

    IF habSimples <= reservasActuales THEN
      RAISE_APPLICATION_ERROR(-20101,'Las reservas superan el número de habitaciones simples');
    END IF;

  END IF;

  IF :NEW.tipoHabitacion = 'Doble' THEN
    SELECT doblesLibres INTO habDobles FROM hotel
    WHERE hotel.idHotel = :NEW.idHotel;

    IF habDobles <= reservasActuales THEN
      RAISE_APPLICATION_ERROR(-20102,'Las reservas superan el número de habitaciones dobles');
    END IF;

  END IF;

END;
/


 -- Restricción 5 --
-- Antes de hacer una nueva reserva, se comprueba que la fecha de entrada sea menor que la de
-- salida, en caso contrario se rechaza la inserción.

CREATE OR REPLACE TRIGGER controlFechasReservas
BEFORE INSERT ON fragmentoReserva
FOR EACH ROW
	WHEN (NEW.fechaEntrada >= NEW.fechaSalida)
BEGIN
  RAISE_APPLICATION_ERROR(-20002,'La fecha de entrada es posterior que la fecha de salida');
END;
/

 -- Restricción 6 --
-- Antes de una nueva reserva, comprobamos que las fechas no se cruzen.

CREATE OR REPLACE TRIGGER controlReservasCliente
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
    numReservas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numReservas FROM reserva
  	WHERE :NEW.idCliente = idCliente
  		AND((fechaEntrada >= :NEW.fechaEntrada AND fechaEntrada < :NEW.fechaSalida)
    		OR(fechaSalida <= :NEW.fechaSalida AND fechaSalida > :NEW.fechaEntrada)
  	);

  IF numReservas > 0 THEN
    RAISE_APPLICATION_ERROR(-20003,'El cliente tiene reservas simultáneas en distintos hoteles');
  END IF;
END;
/

-- Restricción 10 --
-- Antes de actualizar la información de un empleado, se comprueba que el nuevo salario
-- no sea menor que el antiguo.

CREATE OR REPLACE TRIGGER salarioEmpleadoNoDisminuye
BEFORE UPDATE OF salario ON fragmentoEmpleado
FOR EACH ROW WHEN (NEW.salario < OLD.salario)
BEGIN
	RAISE_APPLICATION_ERROR(-20004,'El salario no se puede disminuir');
END;
/

-- Sólo ejectar en magnos2 y magnos4


-- Restricción 12 --
-- Antes de hacer un nuevo suministro, vemos el precioUnidad minimo en los suministros
-- del artículo del que se desea hacer un nuevo suministro. En el caso en el que el nuevo
-- precio sea menor que ese mínimo, rechazamos la inserción.

CREATE OR REPLACE TRIGGER precioSuministroNoMenor
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
	precioMinSumAnteriores fragmentoSuministro.precioUnidad%TYPE;
BEGIN
	SELECT MIN(precioUnidad)
    INTO precioMinSumAnteriores
    FROM suministro
	WHERE :NEW.idArticulo = suministro.idArticulo ;

	IF :NEW.precioUnidad < precioMinSumAnteriores THEN
		RAISE_APPLICATION_ERROR(-20005,'El precio por unidad no puede ser menor respecto a otros suministros');
	END IF;

    COMMIT;
END;
/

-- Restricción 13 --
-- Antes de hacer un nuevo suministro, vemos de que provincia es el proveedor, a continuación
-- contamos el número de veces que se ha suministrado ese artículo por los distintos proveedores
-- que trabajan con esas provincias. En caso de ser más de 2 no permitimos el nuevo suministro.

CREATE OR REPLACE TRIGGER suminArticuloMaxDosProv
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    provinciaProveedor fragmentoProveedor.provincia%TYPE;
    nVecesSuministrado NUMBER;
BEGIN
	SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = proveedor.idProveedor;

	CASE provinciaProveedor
        WHEN 'Granada' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suministro, magnos2.fragmentoProveedor
            WHERE (suministro.idProveedor = magnos2.fragmentoProveedor.idProveedor
                AND suministro.idArticulo = :NEW.idArticulo );

        WHEN 'Sevilla' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suministro, magnos4.fragmentoProveedor
            WHERE (suministro.idProveedor = magnos4.fragmentoProveedor.idProveedor
                AND suministro.idArticulo = :new.idArticulo );

        ELSE RAISE_APPLICATION_ERROR(-20006, 'Provincia del proveedor errónea');
    END CASE;

	IF nVecesSuministrado > 0 THEN
		RAISE_APPLICATION_ERROR(-20106,'Un artículo sólo puede ser suministrado por dos proveedores distintos');
	END IF;

  COMMIT;
END;
/

-- Restricciones 15 y 16  --
-- Antes de hacer un nuevo suministro, vemos la provincia del proveedor que quiere
-- hacer un nuevo suministro, a contunuación antendiendo a la provincia del proveeedor,
-- comprobamos si el nuevo suministro se quiere hacer a una de las provincias de las que
-- el proveedor no puede suministrar.

CREATE OR REPLACE TRIGGER restriccionHotelesProveedores
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
	provinciaProveedor fragmentoProveedor.provincia%TYPE;
	suministrosInvalidos NUMBER;
BEGIN
	SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = idProveedor;

	IF provinciaProveedor = 'Sevilla' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, magnos4.fragmentoHotel
	 	WHERE (:NEW.idHotel = magnos4.fragmentoHotel.idHotel
	 		AND magnos4.fragmentoHotel.idHotel = suministro.idHotel
	 		AND magnos4.fragmentoHotel.provincia IN ('Granada','Jaen','Malaga','Almería'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20007, 'Las ciudades de Granada, Jaén, Málaga y Almería no pueden tener suministros de Sevilla');
	 	END IF;
	END IF;

	IF provinciaProveedor = 'Granada' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, magnos2.fragmentoHotel
	 	WHERE (:NEW.idHotel = magnos2.fragmentoHotel.idHotel
	 		AND magnos2.fragmentoHotel.idHotel = suministro.idHotel
	 		AND magnos2.fragmentoHotel.provincia IN ('Cordoba','Sevilla','Cadiz','Huelva'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20008, 'Las ciudades de Córdoba, Sevilla, Cádiz o Huelva no pueden tener suministros de Granada');
	 	END IF;
	END IF;
END;
/

--Restricción 17 --
-- Antes de borrar un proveedor contamos el número de suministros que ha hecho el proveedor
-- con cantidad mayor que cero, en caso de haber alguno, no se puede eliminar ese proveedor.

 CREATE OR REPLACE TRIGGER borrarProveedor
 BEFORE DELETE ON fragmentoProveedor
 FOR EACH ROW
 DECLARE
 	suministros NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO suministros FROM fragmentoSuministro
 		WHERE :OLD.idProveedor = idProveedor AND cantidad > 0;

 	IF suministros > 0 THEN
 		RAISE_APPLICATION_ERROR(-20009, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;
 /

 --Restricción 18 --
 -- Antes de borrar un artículo se cuenta si existe un suministro con cantidad mayor que cero,
 -- en caso de haber alguno, no se puede eliminar ese artículo.
 
 CREATE OR REPLACE TRIGGER borrarArticulo
 BEFORE DELETE ON articulo
 FOR EACH ROW
 DECLARE
    suministros NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO suministros FROM fragmentoSuministro
 		WHERE :OLD.idArticulo = idArticulo AND cantidad > 0;

  IF suministros > 0 THEN
 		RAISE_APPLICATION_ERROR(-20010, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;
/
