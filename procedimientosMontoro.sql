-- 6. Cambiar el director de un hotel.
CREATE OR REPLACE PROCEDURE cambiarDirector (
    arg_idHotel     hotel.idHotel%TYPE,
    arg_idDirector  hotel.idDirector%TYPE ) AS

    numDirectores   NUMBER;
    numHoteles      NUMBER;
    ciudadHotel     hotel.ciudad%TYPE;
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

-- 13. Dar de alta o actualizar una reserva