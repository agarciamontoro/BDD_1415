 CREATE OR REPLACE TRIGGER hotelGJMAnotPS
 BEFORE INSERT ON suministro
 FOR EACH ROW
 DECLARE
 	error NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO error FROM hotel,suministro,proveedor
 		WHERE hotel.idHotel=suministro.idHotel AND
 			suministro.idProveedor = proveedor.idProveedor AND
 			hotel.ciudad IN ('Granada','Jaen','Malaga','Almeria') AND
 			proveedor.ciudad = 'Sevilla';

 		IF error > 0 THEN
 			RAISE_APPLICATION_ERROR(-20015, 'Las ciudades de Granada, Jaén, Málaga y Almería no pueden tener suministros de Sevilla');
 		END IF;
 END;

 CREATE OR REPLACE TRIGGER hotelCSCHnotPG
 BEFORE INSERT ON suministro
 FOR EACH ROW
 DECLARE
 	error NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO error FROM hotel,suministro,proveedor
 		WHERE hotel.idHotel=suministro.idHotel AND
 			suministro.idProveedor = proveedor.idProveedor AND
 			hotel.ciudad IN ('Cordoba','Sevilla','Cadiz','Huelva') AND
 			proveedor.ciudad = 'Granada';

 		IF error > 0 THEN
 			RAISE_APPLICATION_ERROR(-20016, 'Las ciudades de Córdoba, Sevilla, Cádiz o Huelva no pueden tener suministros de Granada');
 		END IF;
 END;

