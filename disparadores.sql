-- Restricción 4
CREATE OR REPLACE TRIGGER capacidadReservas
BEFORE INSERT OR UPDATE ON reserva
FOR EACH ROW
DECLARE
  habSimples NUMBER;
  habDobles  NUMBER;
  reservasActuales    NUMBER;
BEGIN
  --¿ Tabla Mutante ?
  SELECT COUNT(*) INTO reservasActuales FROM reserva
  WHERE tipoHabitacion = NEW.tipoHabitacion
  	AND((:NEW.fechaEntrada >= fechaEntrada AND :NEW.fechaEntrada < fechaSalida)
  		OR(:NEW.fechaEntrada <= fechaEntrada AND :NEW.fechaSalida > fechaEntrada)
  );

  IF NEW.tipoHabitacion = 'Simple' THEN
    SELECT sencillasLibres INTO habSimples FROM hotel,reserva
    WHERE hotel.idHotel=reserva.idHotel
    	AND reserva.idHotel=:NEW.idHotel;

    IF habSimples < reservasActualesSimples THEN
      RAISE_APPLICATION_ERROR(-20001,'Las reservas superan el número de habitaciones simples')
    END IF;

  END IF;

  IF NEW.tipoHabitacion = 'Doble' THEN

    SELECT doblesLibres INTO habDobles FROM hotel,reserva
    WHERE hotel.idHotel=reserva.idHotel
    	AND reserva.idHotel=:NEW.idHotel;

    IF habDobles < reservasActualesDobles THEN
      RAISE_APPLICATION_ERROR(-20001,'Las reservas superan el número de habitaciones dobles')
    END IF;

  END IF;

END;

 -- Restricción 5 (Hecho) --
CREATE OR REPLACE TRIGGER controlFechasReservas
BEFORE INSERT ON fragmentoReserva
FOR EACH ROW
	WHEN :NEW.fechaEntrada >= :NEW.fechaSalida
BEGIN
  RAISE_APPLICATION_ERROR(-20002,'La fecha de entrada es mayor que la fecha de salida')
END;

 -- Restricción 6
CREATE OR REPLACE TRIGGER controlReservasCliente
BEFORE INSERT OR UPDATE ON reserva
FOR EACH ROW
DECLARE
    numReservas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numReservas FROM reserva
  	WHERE :NEW.idCliente = idCliente
  		AND((:NEW.FechaInicio >= FechaInicio AND :NEW.FechaInicio < FechaFin)
    		OR(:NEW.FechaInicio <= FechaInicio AND :NEW.FechaFin > FechaInicio)
  	);

  IF numReservas > 0 THEN
    RAISE_APPLICATION_ERROR(-20003,'El cliente tiene reservas simultáneas en distintos hoteles')
  END IF;
END;

-- Restricción 10 (Hecho)--
CREATE OR REPLACE TRIGGER salarioEmpleadoNoPuedeDisminuir
BEFORE UPDATE OF salario ON empleado
FOR EACH ROW
	WHEN NEW.salario < OLD.salario
BEGIN
	RAISE_APPLICATION_ERROR(-20004,'El salario no se puede disminuir');
END;

-- Restricción 12 (Hecho)--
CREATE OR REPLACE TRIGGER precioSuministroNoMenor
BEFORE INSERT ON suministro
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
	precioMinSumAnteriores fragmentoSuministro.precioUnidad%TYPE;
BEGIN
	SELECT MIN(precioPorUnidad)
    INTO precioMinSumAnteriores
    FROM suministro
	WHERE :NEW.idArticulo = suministro.idArticulo ;

	IF NEW.precioUnidad < precioMinSumAnteriores THEN
		RAISE_APPLICATION_ERROR(-20005,'El precio por unidad no puede ser menor respecto a otros suministros');
	END IF;

    COMMIT;
END;

-- Restricción 13 (Hecho)--
CREATE OR REPLACE TRIGGER suministroArticuloMaxDosProvincias
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    ciudadProveedor fragmentoProveedor.ciudad%TYPE;
	nVecesSuministrado NUMBER;
BEGIN
	SELECT ciudad
    INTO ciudadProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = proveedor.idProveedor;

	CASE ciudadProveedor
        WHEN 'Granada' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suministro, magnos2.fragmentoProveedor
            WHERE (suministro.idProveedor = magnos2.fragmentoProveedor.idProveedor
                AND suministro.idArticulo = :NEW.idArticulo
                AND magnos2.fragmentoProveedor.ciudad = ciudadProveedor );

        WHEN 'Sevilla' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suminstro, magnos4.fragmentoProveedor
            WHERE (suministro.idProveedor = magnos4.fragmentoProveedor.idProveedor
                AND suministro.idArticulo = :new.idArticulo
                AND magnos2.fragmentoProveedor.ciudad = ciudadProveedor );

        ELSE RAISE_APPLICATION_ERROR(-20006, 'Ciudad del proveedor errónea');
    END CASE;

	IF nVecesSuministrado > 1 THEN
		RAISE_APPLICATION_ERROR(-20006,'Un artículo sólo puede ser suministrado por dos proveedores distintos');
	END IF;

    COMMIT;
END;

-- Restricciones 15 y 16 --
CREATE OR REPLACE TRIGGER restriccionHotelesProveedores
BEFORE INSERT ON suministro
FOR EACH ROW
DECLARE
	ciudadNuevoSuministro VARCHAR(50);
	error NUMBER;
BEGIN
	SELECT provincia INTO ciudadNuevoSuministro	FROM proveedor
	WHERE :NEW.idProveedor = proveedor.idProveedor;

	IF ciudadNuevoSuministro = 'Sevilla'
		SELECT COUNT(*) INTO error FROM hotel,suministro
	 	WHERE (:NEW.idHotel = hotel.idHotel
	 		AND hotel.idHotel = suministro.idHotel
	 		AND hotel.ciudad IN ('Granada','Jaen','Malaga','Almería'));

	 	IF error > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20007, 'Las ciudades de Granada, Jaén, Málaga y Almería no pueden tener suministros de Sevilla');
	 	END IF;
	END IF;

	IF ciudadNuevoSuministro = 'Granada'
		SELECT COUNT(*) INTO error FROM hotel,suministro
	 	WHERE (:NEW.idHotel = hotel.idHotel
	 		AND hotel.idHotel = suministro.idHotel
	 		AND hotel.ciudad IN ('Cordoba','Sevilla','Cadiz','Huelva'));

	 	IF error > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20008, 'Las ciudades de Córdoba, Sevilla, Cádiz o Huelva no pueden tener suministros de Granada');
	 	END IF;
	END IF;
END;

 --Restricción 17 --
 CREATE OR REPLACE TRIGGER
 BEFORE DELETE ON proveedor
 FOR EACH ROW
 DECLARE
 	error NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO error FROM suministro
 		WHERE suministro.idArticulo = :OLD.idProveedor
 			AND suministro.cantidad > 0;

 	IF error > 0 THEN
 		RAISE_APPLICATION_ERROR(-20009, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;

 --Restricción 18 --
 CREATE OR REPLACE TRIGGER
 BEFORE DELETE ON articulo
 FOR EACH ROW
 DECLARE
 	error NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO error FROM suministro
 		WHERE suministro.idArticulo = :OLD.idArticulo
 			AND suministro.cantidad > 0;

 	IF error > 0 THEN
 		RAISE_APPLICATION_ERROR(-20010, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;
