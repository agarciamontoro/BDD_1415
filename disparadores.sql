-- Restricción 4 (Hecho) --
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
      RAISE_APPLICATION_ERROR(-20001,'Las reservas superan el número de habitaciones simples');
    END IF;

  END IF;

  IF :NEW.tipoHabitacion = 'Doble' THEN
    SELECT doblesLibres INTO habDobles FROM hotel
    WHERE hotel.idHotel = :NEW.idHotel;

    IF habDobles <= reservasActuales THEN
      RAISE_APPLICATION_ERROR(-21001,'Las reservas superan el número de habitaciones dobles');
    END IF;

  END IF;

END;
/

 -- Restricción 5 (Hecho) --
CREATE OR REPLACE TRIGGER controlFechasReservas
BEFORE INSERT ON fragmentoReserva
FOR EACH ROW
	WHEN (NEW.fechaEntrada >= NEW.fechaSalida)
BEGIN
  RAISE_APPLICATION_ERROR(-20002,'La fecha de entrada es mayor que la fecha de salida');
END;
/

 -- Restricción 6 (Hecho) --
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

-- Restricción 10 (Hecho) No rula todavia --
CREATE OR REPLACE TRIGGER salarioEmpleadoNoDisminuye
BEFORE UPDATE OF salario ON fragmentoEmpleado
FOR EACH ROW WHEN (NEW.salario < OLD.salario)
BEGIN
	RAISE_APPLICATION_ERROR(-20004,'El salario no se puede disminuir');
END;
/

/* Sólo ejectar en magnos2 y magnos4 */
-- Restricción 12 (Hecho)--
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

/* Se arreglará más adelante
-- Restricción 13 (Hecho)--
CREATE OR REPLACE TRIGGER suminArticuloMaxDosProv
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
                AND magnos4.fragmentoProveedor.ciudad = ciudadProveedor );

        ELSE RAISE_APPLICATION_ERROR(-20006, 'Ciudad del proveedor errónea');
    END CASE;

	IF nVecesSuministrado > 1 THEN
		RAISE_APPLICATION_ERROR(-21006,'Un artículo sólo puede ser suministrado por dos proveedores distintos');
	END IF;

  COMMIT;
END;
/

*/

-- Restricciones 15 y 16 (Hecho) --
CREATE OR REPLACE TRIGGER restriccionHotelesProveedores
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
	ciudadProveedor fragmentoProveedor.ciudad%TYPE;
	suministrosInvalidos NUMBER;
BEGIN
	SELECT ciudad
    INTO ciudadProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = idProveedor;

	IF ciudadProveedor = 'Sevilla' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, magnos4.fragmentoHotel
	 	WHERE (:NEW.idHotel = magnos4.fragmentoHotel.idHotel
	 		AND magnos4.fragmentoHotel.idHotel = suministro.idHotel
	 		AND magnos4.fragmentoHotel.ciudad IN ('Granada','Jaen','Malaga','Almería'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20007, 'Las ciudades de Granada, Jaén, Málaga y Almería no pueden tener suministros de Sevilla');
	 	END IF;
	END IF;

	IF ciudadProveedor = 'Granada' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, magnos2.fragmentoHotel
	 	WHERE (:NEW.idHotel = magnos2.fragmentoHotel.idHotel
	 		AND magnos2.fragmentoHotel.idHotel = suministro.idHotel
	 		AND magnos2.fragmentoHotel.ciudad IN ('Cordoba','Sevilla','Cadiz','Huelva'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20008, 'Las ciudades de Córdoba, Sevilla, Cádiz o Huelva no pueden tener suministros de Granada');
	 	END IF;
	END IF;
END;
/

 --Restricción 17 (Hecho)--
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

 --Restricción 18 (Hecho)--
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

