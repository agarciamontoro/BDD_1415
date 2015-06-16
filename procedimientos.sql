-- 1. Dar de alta a un nuevo empleado. --
CREATE OR REPLACE PROCEDURE altaEmpleado(
    arg_idEmpleado    fragmentoEmpleado.idEmpleado%TYPE,
    arg_dni fragmentoEmpleado.dni%TYPE,
    arg_nombre  fragmentoEmpleado.nombre%TYPE,
    arg_direccion    fragmentoEmpleado.direccion%TYPE,
    arg_telefono fragmentoEmpleado.telefono%TYPE,
    arg_fechaContrato fragmentoEmpleado.fechaContrato%TYPE,
    arg_salario    fragmentoEmpleado.salario%TYPE,
    arg_idHotel    fragmentoHotel.idHotel%TYPE) AS

    provinciaHotel fragmentoHotel.provincia%TYPE;
BEGIN
    SELECT provincia
    INTO provinciaHotel
    FROM Hotel
    WHERE idHotel=arg_idHotel;

    IF ( provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos1.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen' ) THEN
        INSERT INTO magnos2.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos2.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria' ) THEN
        INSERT INTO magnos3.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos3.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba' ) THEN
        INSERT INTO magnos4.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos4.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSE
        RAISE_APPLICATION_ERROR(-20401, 'Provincia de Hotel erronea');
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
-- Los atributos en los que no se especifica lo que se hace con ellos, hemos decidido copiarlos al nuevo destino
CREATE OR REPLACE PROCEDURE trasladarEmpleado (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE,
    arg_idHotel fragmentoTrabaja.idHotel%TYPE,
    arg_direccion fragmentoEmpleado.direccion%TYPE DEFAULT NULL,
    arg_telefono fragmentoEmpleado.telefono%TYPE DEFAULT NULL)AS

    dniEmpleado fragmentoEmpleado.dni%TYPE;
    nombreEmpleado  fragmentoEmpleado.nombre%TYPE;
    fechaContratoEmpleado   fragmentoEmpleado.fechaContrato%TYPE;
    salarioEmpleado  fragmentoEmpleado.salario%TYPE;

BEGIN

    SELECT dni, nombre, fechaContrato, salario
    INTO dniEmpleado, nombreEmpleado, fechaContratoEmpleado, salarioEmpleado
    FROM empleado
    WHERE idEmpleado = arg_idEmpleado;

    bajaEmpleado(arg_idEmpleado);
    altaEmpleado(arg_idEmpleado,
                 dniEmpleado,
                 nombreEmpleado,
                 arg_direccion,
                 arg_telefono,
                 fechaContratoEmpleado,
                 salarioEmpleado,
                 arg_idHotel
                 );
END;
/

-- 5. Dar de alta un nuevo hotel --
CREATE OR REPLACE PROCEDURE altaHotel (
    arg_idHotel    fragmentoHotel.idHotel%TYPE,
    arg_nombre  fragmentoHotel.nombre%TYPE,
    arg_provincia fragmentoHotel.provincia%TYPE,
    arg_ciudad  fragmentoHotel.ciudad%TYPE,
    arg_sencillasLibres fragmentoHotel.sencillasLibres%TYPE,
    arg_doblesLibres  fragmentoHotel.doblesLibres%TYPE ) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Alta hotel en: ' || arg_provincia || ' marchando');
    IF ( arg_provincia = 'Cadiz' OR arg_provincia = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Granada' OR arg_provincia = 'Jaen' ) THEN
        INSERT INTO magnos2.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Malaga' OR arg_provincia = 'Almeria' ) THEN
        INSERT INTO magnos3.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Sevilla' OR arg_provincia = 'Cordoba' ) THEN
        INSERT INTO magnos4.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSE
        RAISE_APPLICATION_ERROR(-20402, 'Provincia erronea');
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
        RAISE_APPLICATION_ERROR(-20403, 'Este empleado ya dirige un hotel');
    END IF;

    -- Si el hotel no existe, error. Si existe, modificamos la tupla
    -- insertando (o cambiando si ya tenia uno) su director
    SELECT COUNT(*) INTO numHoteles
    FROM Hotel
    WHERE idHotel = arg_idHotel;

    IF numHoteles = 0 THEN
        RAISE_APPLICATION_ERROR(-20404, 'Este hotel no existe en la base de datos');
    ELSE
        UPDATE Hotel
        SET idDirector = arg_idDirector
        WHERE idHotel = arg_idHotel;
    END IF;
END;
/

-- 7. Dar de alta a un nuevo cliente --
CREATE OR REPLACE PROCEDURE nuevoCliente (
    arg_idCliente    cliente.idCliente%TYPE,
    arg_DNI     cliente.DNI%TYPE,
    arg_nombre  cliente.nombre%TYPE,
    arg_telefono    cliente.telefono%TYPE ) AS

    clientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO clientes FROM cliente WHERE idCliente=arg_idCliente OR DNI=arg_DNI;

    IF clientes = 0 THEN
        INSERT INTO magnos1.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos2.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos3.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos4.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
    ELSE
        RAISE_APPLICATION_ERROR(-20405,'Este cliente ya existe');
    END IF;
END;
/

-- 8. Dar de alta o actualizar una reserva
CREATE OR REPLACE PROCEDURE actualizarReserva (
    arg_idCliente       cliente.idCliente%TYPE,
    arg_idHotel         hotel.idHotel%TYPE,
    arg_tipoHab         reserva.tipoHabitacion%TYPE,
    arg_precio          reserva.precioNoche%TYPE,
    arg_fechaEntrada    reserva.fechaEntrada%TYPE,
    arg_fechaSalida     reserva.fechaSalida%TYPE ) AS

    numReservas NUMBER;
    provinciaHotel hotel.provincia%TYPE;
BEGIN

    SELECT COUNT(*) INTO numReservas
    FROM Reserva
    WHERE   idCliente = arg_idCliente
            AND
            fechaEntrada = arg_fechaEntrada
            AND
            fechaSalida = arg_fechaSalida;

    -- Si hay una reserva con los datos suministrados, basta actualizarla
    -- en la vista. Si no, se inserta según la provincia correspondiente a idHotel.
    IF numReservas > 0 THEN
        UPDATE  Reserva
        SET     idCliente = arg_idCliente,
                idHotel = arg_idHotel,
                tipoHabitacion   = arg_tipoHab,
                precioNoche = arg_precio,
                fechaEntrada = arg_fechaEntrada,
                fechaSalida = arg_fechaSalida
        WHERE   idCliente = arg_idCliente
                AND
                fechaEntrada = arg_fechaEntrada
                AND
                fechaSalida = arg_fechaSalida;
    ELSE
        SELECT provincia INTO provinciaHotel
        FROM Hotel
        WHERE idHotel = arg_idHotel;

        IF (provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva') THEN
            INSERT INTO magnos1.fragmentoReserva
            (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
            VALUES
            (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
        ELSIF (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen') THEN
            INSERT INTO magnos2.fragmentoReserva
            (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
            VALUES
            (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
        ELSIF (provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria') THEN
            INSERT INTO magnos3.fragmentoReserva
            (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
            VALUES
            (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
        ELSIF (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba') THEN
            INSERT INTO magnos4.fragmentoReserva
            (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
            VALUES
            (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
        END IF;

    END IF;
END;
/

-- 9. Anular reserva (creo que esta bien, revisar porfa) --
CREATE OR REPLACE PROCEDURE anularReserva (
    arg_idCliente fragmentoReserva.idCliente%TYPE,
    arg_idHotel fragmentoReserva.idHotel%TYPE,
    arg_fechaEntrada fragmentoReserva.fechaEntrada%TYPE,
    arg_fechaSalida    fragmentoReserva.fechaSalida%TYPE ) AS

    provinciaHotel fragmentoHotel.provincia%TYPE;
BEGIN
    SELECT provincia INTO provinciaHotel FROM fragmentoHotel WHERE idHotel=arg_idHotel;

    IF ( provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva' ) THEN
        DELETE FROM magnos1.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen' ) THEN
        DELETE FROM magnos2.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria' ) THEN
        DELETE FROM magnos3.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba' ) THEN
        DELETE FROM magnos4.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSE
        RAISE_APPLICATION_ERROR(-20406, 'Provincia de Hotel erronea');
    END IF;
END;
/

-- 10. Dar de alta a un nuevo proveedor. --
CREATE OR REPLACE PROCEDURE altaProveedor(
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE,
    arg_nombre  magnos2.fragmentoProveedor.nombre%TYPE,
    arg_provincia magnos2.fragmentoProveedor.provincia%TYPE) AS
BEGIN
    CASE arg_provincia
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        ELSE
            RAISE_APPLICATION_ERROR(-20407, 'Provincia erronea');
    END CASE;
END;
/

-- 11. Dar de baja a un proveedor. --
CREATE OR REPLACE PROCEDURE bajaProveedor(
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE) AS
BEGIN
    DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
    DELETE FROM magnos4.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
END;
/

-- 12. Dar de alta o actualizar un suministro --
CREATE OR REPLACE PROCEDURE altaActualizaSuministro(
    arg_idArticulo          magnos2.fragmentoSuministro.idArticulo%TYPE,
    arg_idProveedor         magnos2.fragmentoSuministro.idProveedor%TYPE,
    arg_idHotel            	magnos2.fragmentoSuministro.idHotel%TYPE,
    arg_fecha               magnos2.fragmentoSuministro.fecha%TYPE,
    arg_cantidad        	magnos2.fragmentoSuministro.cantidad%TYPE,
    arg_precioUnidad 		magnos2.fragmentoSuministro.precioUnidad%TYPE) AS

    yaExiste            number;
    provinciaProveedor  magnos2.fragmentoProveedor.provincia%TYPE;
BEGIN
    -- lo borramos si esta
    DELETE FROM magnos2.fragmentoSuministro WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor
        AND idArticulo = arg_idArticulo AND fecha = arg_fecha;
    DELETE FROM magnos4.fragmentoSuministro WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor
        AND idArticulo = arg_idArticulo AND fecha = arg_fecha;

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoSuministro(idArticulo,idProveedor,idHotel,fecha,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fecha,arg_cantidad,arg_precioUnidad);
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoSuministro(idArticulo,idProveedor,idHotel,fecha,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fecha,arg_cantidad,arg_precioUnidad);
        ELSE
            RAISE_APPLICATION_ERROR(-20408, 'Provincia erronea');
    END CASE;
END;
/

-- 13. Dar de baja un suministro.
CREATE OR REPLACE PROCEDURE bajaSuministros (
    arg_idHotel     suministro.idHotel%TYPE,
    arg_idProveedor suministro.idProveedor%TYPE,
    arg_idArticulo  suministro.idArticulo%TYPE,
    arg_fecha       suministro.fecha%TYPE DEFAULT NULL ) AS
BEGIN
    -- Si no hay fecha, eliminamos todas las que tengan los otros dos parametros
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
                idProveedor = arg_idProveedor
                AND
                fecha = arg_fecha;
    END IF;
END;
/

-- 14. Dar de alta un nuevo articulo. --
CREATE OR REPLACE PROCEDURE altaArticulo(
    arg_idArticulo    magnos2.articulo.idArticulo%TYPE,
    arg_nombre  magnos2.articulo.nombre%TYPE,
    arg_tipo    magnos2.articulo.tipo%TYPE,
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE) AS

    provinciaProveedor magnos2.fragmentoProveedor.provincia%TYPE;
BEGIN
    -- El disparador de replicacion se ocupa de insertar articulo en magnos4
    INSERT INTO magnos2.articulo(idArticulo,nombre,tipo)
        VALUES (arg_idArticulo,arg_nombre,arg_tipo);

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada' THEN
            INSERT INTO magnos2.fragmentoTiene(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoTiene(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        ELSE
            RAISE_APPLICATION_ERROR(-20409, 'Provincia erronea');
    END CASE;
END;
/

-- 15. Dar de baja un articulo. --
CREATE OR REPLACE PROCEDURE bajaArticulo (
    arg_idArticulo  articulo.idArticulo%TYPE ) AS
BEGIN
  DELETE FROM magnos2.fragmentoSuministro WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.fragmentoSuministro WHERE idArticulo=arg_idArticulo;

  DELETE FROM magnos2.articulo WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.articulo WHERE idArticulo=arg_idArticulo;
END;
/
