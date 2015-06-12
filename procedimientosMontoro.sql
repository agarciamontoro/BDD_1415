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