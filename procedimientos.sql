
CREATE OR REPLACE PROCEDURE altaHotel (
    arg_idHotel    fragmentoHotel.idHotel%TYPE,
    arg_nombre  fragmentoHotel.nombre%TYPE,
    arg_ciudad  fragmentoHotel.ciudad%TYPE,
    arg_ciudad fragmentoHotel.ciudad%TYPE,
    arg_sencillasLibres fragmentoHotel.sencillasLibres%TYPE,
    arg_doblesLibres  fragmentoHotel.doblesLibres%TYPE ) AS
BEGIN
    IF ( arg_ciudad = 'Cádiz' OR arg_ciudad = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoHotel(idHotel,nombre,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_ciudad,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_ciudad = 'Granada' OR arg_ciudad = 'Jaén' ) THEN
        INSERT INTO magnos2.fragmentoHotel(idHotel,nombre,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_ciudad,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_ciudad = 'Málaga' OR arg_ciudad = 'Almería' ) THEN
        INSERT INTO magnos3.fragmentoHotel(idHotel,nombre,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_ciudad,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSIF ( arg_ciudad = 'Sevilla' OR arg_ciudad = 'Córdoba' ) THEN
        INSERT INTO magnos4.fragmentoHotel(idHotel,nombre,ciudad,ciudad,sencillasLibres,sencillasDobles)
        VALUES (arg_idHotel,arg_nombre,arg_ciudad,arg_ciudad,arg_sencillasLibres,arg_sencillasDobles);
    ELSE
        RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
    END IF;
END;


-- Cambiar director hotel (está sin terminar)

/*
CREATE OR REPLACE PROCEDURE cambiarDirector (
    arg_idHotel    dirige_fr.idHotel%TYPE,
    arg_idEmpleado    dirige_fr.idEmpleado%TYPE ) AS

    directores  NUMBER;
    hoteles     NUMBER;
    BEGIN
        -- Si ya está dicho director en la tabla, abortar
        SELECT COUNT(*) INTO directores FROM dirige_v WHERE idEmpleado=arg_idEmpleado;

        IF directores > 0 THEN
            RAISE_APPLICATION_ERROR(-24020, 'El director introducido ya dirige un hotel');
        END IF;

        -- Si no está el director pero sí el hotel, borrar director
        SELECT COUNT(*) INTO hoteles FROM dirige_v WHERE idHotel=arg_idHotel;

        IF hoteles > 0 THEN
            DELETE FROM dirige_fr WHERE idHotel=arg_idHotel;
        END IF;

        SELECT ciudad INTO ciudadHotel FROM hotel_v WHERE idHotel=arg_idHotel;

        -- Añadir director
        CASE ciudadHotel
            WHEN 'Cádiz' THEN
                INSERT INTO magnos1.dirige_fr(idHotel,idEmpleado)
                VALUES (arg_idHotel,arg_idEmpleado);
            WHEN 'Granada'THEN
              INSERT INTO magnos2.dirige_fr(idHotel,idEmpleado)
              VALUES (arg_idHotel,arg_idEmpleado);
            WHEN 'Málaga'THEN
              INSERT INTO magnos3.dirige_fr(idHotel,idEmpleado)
              VALUES (arg_idHotel,arg_idEmpleado);
            WHEN 'Sevilla' THEN
              INSERT INTO magnos4.dirige_fr(idHotel,idEmpleado)
              VALUES (arg_idHotel,arg_idEmpleado);
            ELSE
                RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
        END CASE;
END;
*/


CREATE OR REPLACE PROCEDURE altaEmpleado(
    arg_idEmpleado    fragmentoEmpleado.idEmpleado%TYPE,
    arg_dni fragmentoEmpleado.dni%TYPE,
    arg_nombre  fragmentoEmpleado.nombre%TYPE,
    arg_dire    fragmentoEmpleado.direccion%TYPE,
    arg_tel fragmentoEmpleado.telefono%TYPE,
    arg_ini fragmentoEmpleado.fechaContrato%TYPE,
    arg_sala    fragmentoEmpleado.salario%TYPE,
    arg_idHotel    fragmentoEmpleado.idHotel%TYPE) AS

    ciudadHotel fragmentoHotel.ciudad%TYPE;
BEGIN
    SELECT ciudad
    INTO ciudadHotel
    FROM fragmentoHotel
    WHERE idHotel=arg_idHotel;

    IF ( ciudadHotel = 'Cádiz' OR ciudadHotel = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario,idHotel)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_tel,arg_dire,arg_ini,arg_sala,arg_idHotel);
    ELSIF ( ciudadHotel = 'Granada' OR ciudadHotel = 'Jaén' ) THEN
        INSERT INTO magnos2.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario,idHotel)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_tel,arg_dire,arg_ini,arg_sala,arg_idHotel);
    ELSIF ( ciudadHotel = 'Málaga' OR ciudadHotel = 'Almería' ) THEN
        INSERT INTO magnos3.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario,idHotel)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_tel,arg_dire,arg_ini,arg_sala,arg_idHotel);
    ELSIF ( ciudadHotel = 'Sevilla' OR ciudadHotel = 'Córdoba' ) THEN
        INSERT INTO magnos4.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario,idHotel)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_tel,arg_dire,arg_ini,arg_sala,arg_idHotel);
    ELSE
        RAISE_APPLICATION_ERROR(-24001, 'ciudad de Hotel errónea');
    END IF;
END;


CREATE OR REPLACE PROCEDURE nuevoCliente (
    arg_idCliente    fragmentoCliente.idCliente%TYPE,
    arg_DNI     fragmentoCliente.DNI%TYPE,
    arg_nombre  fragmentoCliente.nombre%TYPE,
    arg_telefono    fragmentoCliente.telefono%TYPE ) AS

    clientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO clientes FROM fragmentoCliente WHERE idCliente=arg_idCliente OR DNI=arg_DNI;

    IF clientes = 0 THEN
        INSERT INTO magnos1.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos2.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos3.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos4.fragmentoCliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
    ELSE
        RAISE_APPLICATION_ERROR(-24030,'Este cliente ya existe');
    END IF;
END;


-- Anular reserva (creo que está bien, revisar porfa)
CREATE OR REPLACE anularReserva (
    arg_idCliente fragmentoReserva.idCliente%TYPE,
    arg_idHotel fragmentoReserva.idHotel%TYPE,
    arg_fechaInicio fragmentoReserva.fechaInicio%TYPE,
    arg_fechaFin    fragmentoReserva.fechaFin%TYPE ) AS

    ciudadHotel fragmentoHotel.ciudad%TYPE;
BEGIN
    SELECT ciudad INTO ciudadHotel FROM fragmentoHotel WHERE idHotel=arg_idHotel;

    IF ( ciudadHotel = 'Cádiz' OR ciudadHotel = 'Huelva' ) THEN
        DELETE FROM magnos1.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( ciudadHotel = 'Granada' OR ciudadHotel = 'Jaén' ) THEN
        DELETE FROM magnos2.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( ciudadHotel = 'Málaga' OR ciudadHotel = 'Almería' ) THEN
        DELETE FROM magnos3.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSIF ( ciudadHotel = 'Sevilla' OR ciudadHotel = 'Córdoba' ) THEN
        DELETE FROM magnos4.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaInicio=arg_fechaInicio AND fechaFin=arg_fechaFin;
    ELSE
        RAISE_APPLICATION_ERROR(-24001, 'ciudad de Hotel errónea');
    END IF;
END;


CREATE OF REPLACE PROCEDURE altaProveedor(
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE,
    arg_nombre  fragmentoProveedor.nombre%TYPE,
    arg_ciudad  fragmentoProveedor.ciudad%TYPE) AS
BEGIN
    CASE arg_ciudad
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoProveedor(idProveedor,nombre,ciudad)
            VALUES (arg_idProveedor,arg_nombre,arg_ciudad) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,nombre,ciudad)
            VALUES (arg_idProveedor,arg_nombre,arg_ciudad) ;
        ELSE
            RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
    END;
END;


CREATE OF REPLACE PROCEDURE bajaProveedor(
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE) AS
BEGIN
    DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
    DELETE FROM magnos4.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
END;



CREATE OF REPLACE PROCEDURE altaActualizaSuministro(
    arg_idArticulo            fragmentoSuministro.idProveedor%TYPE,
    arg_idProveedor            fragmentoSuministro.nombre%TYPE,
    arg_idHotel            fragmentoSuministro.ciudad%TYPE,
    arg_fechaSuministro fragmentoSuministro.fechaSuministro%TYPE,
    arg_cantidad        fragmentoSuministro.cantidad%TYPE,
    arg_precioUnidad fragmentoSuministro.precioUnidad%TYPE) AS

    yaExiste            number;
    ciudadHotel      fragmentoHotel.ciudad%TYPE;
    ciudadViejaHotel fragmentoHotel.ciudad%TYPE;
BEGIN
    SELECT COUNT(*)
    INTO yaExiste
    FROM suministro_v
    WHERE fragmentoSuministro.idArticulo = arg_idArticulo AND fragmentoSuministro.idHotel = arg_idHotel
        AND fragmentoSuministro.idProveedor = arg_idProveedor AND fragmentoSuministro.fechaSuministro = arg_fechaSuministro;

    IF yaExiste > 0 THEN
        DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
        DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
    ELSE IF;

    CASE ciudadHotel
        WHEN 'Cádiz' THEN
            INSERT INTO magnos1.fragmentoHotel(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoHotel(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        WHEN 'Málaga'THEN
            INSERT INTO magnos3.fragmentoHotel(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoHotel(idArticulo,idProveedor,idHotel,fechaSuministro,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fechaSuministro,arg_cantidad,arg_precioUnidad);
        ELSE
            RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
    END CASE;
END;


CREATE OF REPLACE PROCEDURE altaArticulo(
    arg_idArticulo    articulo.idArticulo%TYPE,
    arg_nombre  articulo.nombre%TYPE,
    arg_tipo    articulo.tipo%TYPE
    arg_idProveedor    fragmentoProveedor.idProveedor%TYPE) AS

    ciudadProveedor fragmentoProveedor.ciudad%TYPE;
BEGIN
    INSERT INTO magnos2.articulo(idArticulo,nombre,tipo)
        VALUES (arg_idArticulo,arg_nombre,arg_tipo);
    INSERT INTO magnos4.articulo(idArticulo,nombre,tipo)
        VALUES (arg_idArticulo,arg_nombre,arg_tipo);

    SELECT ciudad
    INTO ciudadProveedor
    FROM proveedor_v
    WHERE idProveedor = arg_idProveedor;

    CASE ciudadProveedor
        WHEN 'Granada'THEN
            INSERT INTO magnos2.gestiona_fr(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        ELSE
            RAISE_APPLICATION_ERROR(-24010, 'Ciudad errónea');
    END;
END;


CREATE OR REPLACE bajaArticulo (
    arg_idArticulo  articulo.idArticulo%TYPE ) AS
BEGIN
  DELETE FROM magnos2.fragmentoSuministro WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.fragmentoSuministro WHERE idArticulo=arg_idArticulo;

  DELETE FROM magnos2.articulo WHERE idArticulo=arg_idArticulo;
  DELETE FROM magnos4.articulo WHERE idArticulo=arg_idArticulo;
END;


/*
-- Baja empleado (errores)
CREATE OR REPLACE PROCEDURE bajaEmpleado (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE) AS
    ciudadHotel fragmentoHotel.ciudad%TYPE;
  BEGIN


  SELECT  H.ciudad
    INTO ciudadHotel
    FROM fragmentoHotel H
    WHERE H.idHotel=arg_idHotel;

    IF ( ciudadHotel = 'Cádiz' OR ciudadHotel = 'Huelva' ) THEN
            DELETE FROM magnos1.fragmentoEmpleado E WHERE E.idEmpleado=arg_idEmpleado;
        ELSIF ( ciudadHotel = 'Granada' OR ciudadHotel = 'Jaén' ) THEN
            DELETE FROM magnos1.fragmentoEmpleado E WHERE E.idEmpleado=arg_idEmpleado;

        ELSIF ( ciudadHotel = 'Málaga' OR ciudadHotel = 'Almería' ) THEN

            DELETE FROM magnos1.fragmentoEmpleado E WHERE E.idEmpleado=arg_idEmpleado;

        ELSIF ( ciudadHotel = 'Sevilla' OR ciudadHotel = 'Córdoba' ) THEN
                        DELETE FROM magnos1.fragmentoEmpleado E WHERE E.idEmpleado=arg_idEmpleado;

        ELSE
            RAISE_APPLICATION_ERROR(-24002, 'ciudad de Hotel errónea');
        END IF;
    END;
/
*/
