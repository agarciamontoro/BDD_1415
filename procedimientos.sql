-- 1. Dar de alta a un nuevo empleado. --
CREATE OR REPLACE PROCEDURE altaEmpleado(
    arg_idEmpleado    fragmentoEmpleado.idEmpleado%TYPE,
    arg_dni fragmentoEmpleado.dni%TYPE,
    arg_nombre  fragmentoEmpleado.nombre%TYPE,
    arg_direccion    fragmentoEmpleado.direccion%TYPE,
    arg_telefono fragmentoEmpleado.telefono%TYPE,
    arg_fechaContrato fragmentoEmpleado.fechaContrato%TYPE,
    arg_salario    fragmentoEmpleado.salario%TYPE,
    arg_idHotel    fragmentoEmpleado.idHotel%TYPE) AS

    ciudadHotel fragmentoHotel.ciudad%TYPE;
BEGIN
    SELECT ciudad
    INTO ciudadHotel
    FROM fragmentoHotel
    WHERE idHotel=arg_idHotel;

    IF ( ciudadHotel = 'Cádiz' OR ciudadHotel = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos1.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Granada' OR ciudadHotel = 'Jaén' ) THEN
        INSERT INTO magnos2.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos2.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Málaga' OR ciudadHotel = 'Almería' ) THEN
        INSERT INTO magnos3.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos3.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Sevilla' OR ciudadHotel = 'Córdoba' ) THEN
        INSERT INTO magnos4.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos4.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSE
        RAISE_APPLICATION_ERROR(-24001, 'ciudad de Hotel errónea');
    END IF;
END;
/

-- 2. Dar de baja a un empleado. --
CREATE OR REPLACE PROCEDURE bajaEmpleado (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE ) AS
BEGIN
    DELETE FROM trabaja WHERE idEmpleado = arg_idEmpleado;
    DELETE FROM empleado WHERE idEmpleado = arg_idEmpleado;
END;
/

-- 3. Modificar el salario de un empleado. --
CREATE OR REPLACE PROCEDURE modificarSalario (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE,
    arg_salariorio fragmentoEmpleado.salario%TYPE) AS
BEGIN
    UPDATE empleado
    SET salario = arg_salariorio
    WHERE idEmpleado = arg_idEmpleado;
END;
/

-- 4. Trasladar de hotel a un empleado. --
/* Los atributos en los que no se especifica lo que se hace con ellos, hemos decidido copiarlos al nuevo destino */
CREATE OR REPLACE PROCEDURE trasladarEmpleado (
    arg_idEmpleado fragmentoEmpleado.id_Empleado%TYPE,
    arg_idHotel fragmentoTrabaja.id_Hotel%TYPE,
    arg_direccionccion fragmentoEmpleado.direccion%TYPE = null,
    arg_telefonoefono fragmentoEmpleado.telefono%TYPE = null) AS
BEGIN
    SELECT ciudad
    INTO ciudadHotel
    FROM hotel
    WHERE idHotel = arg_idHotel;

    SELECT dni, nombre, fechaContrato, salario
    INTO dniEmpleado, nombreEmpleado, fechaContratoEmpleado, salarioEmpleadoNoDisminuye
    FROM empleado
    WHERE idEmpleado = arg_idEmpleado;

    DELETE FROM trabaja WHERE idEmpleado = arg_idEmpleado;
    DELETE FROM empleado WHERE IDEmpleado = arg_idEmpleado;

    IF ( ciudadHotel = 'Cádiz' OR ciudadHotel = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,dniEmpleado,nombreEmpleado,arg_telefono,arg_direccion,fechaContratoEmpleado,salarioEmpleado);
        INSERT INTO magnos1.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Granada' OR ciudadHotel = 'Jaén' ) THEN
        INSERT INTO magnos2.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,dniEmpleado,nombreEmpleado,arg_telefono,arg_direccion,fechaContratoEmpleado,salarioEmpleado);
        INSERT INTO magnos2.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Málaga' OR ciudadHotel = 'Almería' ) THEN
        INSERT INTO magnos3.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,dniEmpleado,nombreEmpleado,arg_telefono,arg_direccion,fechaContratoEmpleado,salarioEmpleado);
        INSERT INTO magnos3.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( ciudadHotel = 'Sevilla' OR ciudadHotel = 'Córdoba' ) THEN
        INSERT INTO magnos4.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,dniEmpleado,nombreEmpleado,arg_telefono,arg_direccion,fechaContratoEmpleado,salarioEmpleado);
        INSERT INTO magnos4.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSE
        RAISE_APPLICATION_ERROR(-24001, 'ciudad de Hotel errónea');
    END IF;
END;
/

-- 5. Dar de alta un nuevo hotel --
CREATE OR REPLACE PROCEDURE altaHotel (
    arg_idHotel    fragmentoHotel.idHotel%TYPE,
    arg_nombre  fragmentoHotel.nombre%TYPE,
    arg_ciudad  fragmentoHotel.ciudad%TYPE,
    arg_provincia fragmentoHotel.provincia%TYPE,
    arg_sencillasLibres fragmentoHotel.sencillasLibres%TYPE,
    arg_doblesLibres  fragmentoHotel.doblesLibres%TYPE ) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Alta hotel en: ' || arg_provincia || ' marchando');
    IF ( arg_provincia = 'Cádiz' OR arg_provincia = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoHotel(idHotel,nombre,provincia,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_provincia = 'Granada' OR arg_provincia = 'Jaén' ) THEN
        INSERT INTO magnos2.fragmentoHotel(idHotel,nombre,provincia,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_provincia = 'Málaga' OR arg_provincia = 'Almería' ) THEN
        INSERT INTO magnos3.fragmentoHotel(idHotel,nombre,provincia,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_provincia = 'Sevilla' OR arg_provincia = 'Córdoba' ) THEN
        INSERT INTO magnos4.fragmentoHotel(idHotel,nombre,provincia,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSE
        RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
    END IF;
END;
/

-- 6. Cambiar el director de un hotel.
CREATE OR REPLACE PROCEDURE cambiarDirector (
    arg_idHotel     hotel.idHotel%TYPE,
    arg_idDirector  hotel.idDirector%TYPE ) AS

    numDirectores   NUMBER;
    numHoteles      NUMBER;
BEGIN
    -- Si el director ya dirige un hotel, error.
    SELECT COUNT(*) INTO numDirectores
    FROM Hotel
    WHERE idDirector = arg_idDirector;

    IF numDirectores > 0 THEN
        RAISE_APPLICATION_ERROR(-5000, 'Este empleado ya dirige un hotel');
    END IF;

    -- Si el hotel no existe, error. Si existe, modificamos la tupla
    -- insertando (o cambiando si ya tenía uno) su director
    SELECT COUNT(*) INTO numHoteles
    FROM Hotel
    WHERE idHotel = arg_idHotel;

    IF numHoteles = 0 THEN
        RAISE_APPLICATION_ERROR(-5001, 'Este hotel no existe en la base de datos');
    ELSE    
        UPDATE Hotel
        SET idDirector = arg_idDirector
        WHERE idHotel = arg_idHotel;
    END IF;
END;
/

-- 7. Dar de alta a un nuevo cliente --
CREATE OR REPLACE PROCEDURE nuevoCliente (
    arg_idCliente    fragmentoCliente.idCliente%TYPE,
    arg_DNI     fragmentoCliente.DNI%TYPE,
    arg_nombre  fragmentoCliente.nombre%TYPE,
    arg_telefonoefono    fragmentoCliente.telefono%TYPE ) AS

    clientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO clientes FROM fragmentoCliente WHERE idCliente=arg_idCliente OR DNI=arg_DNI;

    IF clientes = 0 THEN
        INSERT INTO magnos1.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefonoefono);
        INSERT INTO magnos2.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefonoefono);
        INSERT INTO magnos3.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefonoefono);
        INSERT INTO magnos4.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefonoefono);
    ELSE
        RAISE_APPLICATION_ERROR(-24030,'Este cliente ya existe');
    END IF;
END;
/

-- 8. Dar de alta o actualizar una reserva
CREATE OR REPLACE PROCEDURE actualizarReserva (
    arg_idCliente       cliente.idCliente%TYPE,
    arg_idHotel         hotel.idHotel%TYPE 
    arg_tipoHab         reserva.tipoHabitacion%TYPE 
    arg_precio          reserva.precioNoche%TYPE 
    arg_fechaEntrada    reserva.fechaEntrada%TYPE 
    arg_fechaSalida     reserva.fechaSalida%TYPE ) AS

    numReservas NUMBER;
    ciudadHotel hotel.ciudad%TYPE;
BEGIN
    -- Si el director ya dirige un hotel, error.
    SELECT COUNT(*) INTO numReservas
    FROM Reserva
    WHERE   idCliente = arg_idCliente
            AND
            fechaEntrada = arg_fechaEntrada
            AND
            fechaSalida = arg_fechaSalida;

    -- Si hay una reserva con los datos suministrados, basta actualizarla
    -- en la vista. Si no, se inserta según la ciudad correspondiente a idHotel.
    IF numReservas > 0 THEN
        UPDATE  Reserva
        SET     idCliente = arg_idCliente,
                idHotel = arg_idHotel,
                tipoHab = arg_tipoHab,
                precio = arg_precio,
                fechaEntrada = arg_fechaEntrada,
                fechaSalida = arg_fechaSalida
        WHERE   idCliente = arg_idCliente
                AND
                fechaEntrada = arg_fechaEntrada
                AND
                fechaSalida = arg_fechaSalida;
    ELSE
        SELECT ciudad INTO ciudadHotel
        FROM Hotel
        WHERE idHotel = arg_idHotel;

        CASE ciudadHotel
            WHEN 'Cádiz' OR 'Huelva' THEN
                INSERT INTO magnos1.fragmentoReserva
                (idCliente, idHotel, tipoHab, precio, fechaEntrada, fechaSalida, idCliente)
                VALUES
                (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida, arg_idCliente);
            WHEN 'Granada' OR 'Jaén' THEN
                INSERT INTO magnos2.fragmentoReserva
                (idCliente, idHotel, tipoHab, precio, fechaEntrada, fechaSalida, idCliente)
                VALUES
                (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida, arg_idCliente);
            WHEN 'Málaga' OR 'Almería' THEN
                INSERT INTO magnos3.fragmentoReserva
                (idCliente, idHotel, tipoHab, precio, fechaEntrada, fechaSalida, idCliente)
                VALUES
                (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida, arg_idCliente);
            WHEN 'Sevilla' OR 'Córdoba' THEN
                INSERT INTO magnos4.fragmentoReserva
                (idCliente, idHotel, tipoHab, precio, fechaEntrada, fechaSalida, idCliente)
                VALUES
                (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida, arg_idCliente);
        END CASE;
    END IF;
END;
/

-- 9. Anular reserva (creo que está bien, revisar porfa) --
CREATE OR REPLACE anularReserva (
    arg_idCliente fragmentoReserva.idCliente%TYPE,
    arg_idHotel fragmentoReserva.idHotel%TYPE,
    arg_fechaInicio fragmentoReserva.fechaInicio%TYPE,
    arg_fechaFin    fragmentoReserva.fechaFin%TYPE ) AS

    provinciaHotel fragmentoHotel.provincia%TYPE;
BEGIN
    SELECT ciudad INTO ciudadHotel FROM fragmentoHotel WHERE idHotel=arg_idHotel;

    IF ( provinciaHotel = 'Cádiz' OR provinciaHotel = 'Huelva' ) THEN
        DELETE FROM magnos1.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaén' ) THEN
        DELETE FROM magnos2.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( provinciaHotel = 'Málaga' OR provinciaHotel = 'Almería' ) THEN
        DELETE FROM magnos3.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Córdoba' ) THEN
        DELETE FROM magnos4.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSE
        RAISE_APPLICATION_ERROR(-24001, 'Provincia de Hotel errónea');
    END IF;
END;
/

-- 10. Dar de alta a un nuevo proveedor. --
CREATE OF REPLACE PROCEDURE altaProveedor(
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE,
    arg_nombre  fragmentoProveedor.nombre%TYPE,
    arg_provincia fragmentoProveedor.provincia%TYPE) AS
BEGIN
    CASE arg_ciudad
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        ELSE
            RAISE_APPLICATION_ERROR(-24010, 'Provincia errónea');
    END;
END;

-- 11. Dar de baja a un proveedor. --
CREATE OF REPLACE PROCEDURE bajaProveedor(
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE) AS
BEGIN
    DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
    DELETE FROM magnos4.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
END;
/

-- 12. Dar de alta o actualizar un suministro --
CREATE OR REPLACE PROCEDURE altaActualizaSuministro(
    arg_idArticulo          magnos2.fragmentoSuministro.codA%TYPE,
    arg_idProveedor         magnos2.fragmentoSuministro.codP%TYPE,
    arg_idHotel            	magnos2.fragmentoSuministro.codH%TYPE,
    arg_fechaSuministro 	magnos2.fragmentoSuministro.fechaSuministro%TYPE,
    arg_cantidad        	magnos2.fragmentoSuministro.cantidad%TYPE,
    arg_precioUnidad 		magnos2.fragmentoSuministro.precioUnidad%TYPE) AS

    yaExiste            number;
    provinciaProveedor  magnos2.fragmentoProveedor.provincia%TYPE;
BEGIN
    -- lo borramos si esta
    DELETE FROM magnos2.suministro_fr WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor 
        AND idArticulo = arg_idArticulo AND fechaSuministro = arg_fechaSuministro;
    DELETE FROM magnos4.suministro_fr WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor 
        AND idArticulo = arg_idArticulo AND fechaSuministro = arg_fechaSuministro;

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada'THEN
            INSERT INTO magnos2.suministro_fr(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.suministro_fr(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        ELSE
            RAISE_APPLICATION_ERROR(-20000, 'Provincia errónea');
    END CASE;
END;
/

-- 13. Dar de baja un suministro.
CREATE OR REPLACE PROCEDURE bajaSuministros (
    arg_idHotel     suministro.idHotel%TYPE,
    arg_idProveedor suministro.idProveedor%TYPE,
    arg_idArticulo  suministro.idArticulo%TYPE,
    arg_fecha       suministro.fecha%TYPE = null ) AS
BEGIN
    -- Si no hay fecha, eliminamos todas las que tengan los otros dos parámetros
    IF arg_fecha IS NULL THEN
        DELETE FROM Suministro
        WHERE   idHotel = arg_idHotel
                AND
                idArticulo = arg_idArticulo
                AND
                idProveedor = arg_idProveedor;
    -- Si hay fecha, eliminamos esa en concreto
    ELSE
        DELETE FROM Suministro
        WHERE   idHotel = arg_idHotel
                AND
                idArticulo = arg_idArticulo
                AND
                idProveedor = arg_idProveedor;
                AND
                fecha = arg_fecha;
    END IF;
END;
/

-- 14. Dar de alta un nuevo artículo. --
CREATE OF REPLACE PROCEDURE altaArticulo(
    arg_idArticulo    articulo.idArticulo%TYPE,
    arg_nombre  articulo.nombre%TYPE,
    arg_tipo    articulo.tipo%TYPE
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE) AS

    provinciaProveedor fragmentoProveedor.provincia%TYPE;
BEGIN
    INSERT INTO magnos2.articulo(idArticulo,nombre,tipo)
        VALUES (arg_idArticulo,arg_nombre,arg_tipo);
    INSERT INTO magnos4.articulo(idArticulo,nombre,tipo)
        VALUES (arg_idArticulo,arg_nombre,arg_tipo);

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada'THEN
            INSERT INTO magnos2.gestiona_fr(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        ELSE
            RAISE_APPLICATION_ERROR(-24010, 'Provincia errónea');
    END;
END;
/

-- 15. Dar de baja un artículo. --
CREATE OR REPLACE bajaArticulo (
    arg_idArticulo  articulo.idArticulo%TYPE ) AS
BEGIN
  DELETE FROM magnos2.fragmentoSuministro WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.fragmentoSuministro WHERE idArticulo=arg_idArticulo;

  DELETE FROM magnos2.articulo WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.articulo WHERE idArticulo=arg_idArticulo;
END;
/
