--DELETE FROM magnos1.fragmentoSuministro;
--DELETE FROM magnos1.fragmentoTiene;
--DELETE FROM magnos1.articulo;
DELETE FROM magnos1.fragmentoReserva;
DELETE FROM magnos1.cliente;
DELETE FROM magnos1.fragmentoTrabaja;
DELETE FROM magnos1.fragmentoEmpleado;
DELETE FROM magnos1.fragmentoHotel;
--DELETE FROM magnos1.fragmentoProveedor;
DELETE FROM magnos2.fragmentoSuministro;
DELETE FROM magnos2.fragmentoTiene;
DELETE FROM magnos2.articulo;
DELETE FROM magnos2.fragmentoReserva;
DELETE FROM magnos2.cliente;
DELETE FROM magnos2.fragmentoTrabaja;
DELETE FROM magnos2.fragmentoEmpleado;
DELETE FROM magnos2.fragmentoHotel;
DELETE FROM magnos2.fragmentoProveedor;
--DELETE FROM magnos3.fragmentoSuministro;
--DELETE FROM magnos3.fragmentoTiene;
--DELETE FROM magnos3.articulo;
DELETE FROM magnos3.fragmentoReserva;
DELETE FROM magnos3.cliente;
DELETE FROM magnos3.fragmentoTrabaja;
DELETE FROM magnos3.fragmentoEmpleado;
DELETE FROM magnos3.fragmentoHotel;
--DELETE FROM magnos3.fragmentoProveedor;
DELETE FROM magnos4.fragmentoSuministro;
DELETE FROM magnos4.fragmentoTiene;
DELETE FROM magnos4.articulo;
DELETE FROM magnos4.fragmentoReserva;
DELETE FROM magnos4.cliente;
DELETE FROM magnos4.fragmentoTrabaja;
DELETE FROM magnos4.fragmentoEmpleado;
DELETE FROM magnos4.fragmentoHotel;
DELETE FROM magnos4.fragmentoProveedor;

COMMIT;

-- Hotel
execute altaHotel(1,'Colon','Huelva','Huelva',5,15);
execute altaHotel(2,'Muralla','Cadiz','Cadiz',5,15);
execute altaHotel(3,'Fernando III','Sevilla','Sevilla',10,30);
execute altaHotel(4,'Mezquita','Cordoba','Cordoba',5,20);
execute altaHotel(5,'Santo Reino','Jaen','Jaen',5,15);
execute altaHotel(6,'Alhambra','Granada','Granada',0,6);
execute altaHotel(7,'Alcazar','Almeria','Almeria',2,10);
execute altaHotel(8,'Alcazaba','Malaga','Malaga',5,25);
execute altaHotel(9,'Santa Paula','Granada','Granada',10,30);
execute altaHotel(10,'Almerimar','Almeria','El Ejido',5,20);

COMMIT;


-- Empleados
execute altaEmpleado(1,'11111111','Raul','Real 126, Huelva',111111,TO_DATE('21-09-1995','DD-MM-YYYY'),1.800,1);
execute altaEmpleado(2,'22222222','Federico','Zoraida 25, Cadiz',222222,TO_DATE('25-08-1994','DD-MM-YYYY'),1.800,2);
execute altaEmpleado(3,'33333333','Natalia','Triana 2, Sevilla',333333,TO_DATE('30-01-1997','DD-MM-YYYY'),1.800,3);
execute altaEmpleado(4,'44444444','Amalia','Iglesias 25, Cordoba',444444,TO_DATE('13-02-1998','DD-MM-YYYY'),1.800,4);
execute altaEmpleado(5,'55555555','Susana','05or 5, Jaen',555555,TO_DATE('1-10-2003','DD-MM-YYYY'),1.800,5);
execute altaEmpleado(6,'66666666','Gonzalo','Ronda 31, Granada',666666,TO_DATE('1-01-1992','DD-MM-YYYY'),1.800,6);
execute altaEmpleado(7,'77777777','Agustin','Costa 32, Almeria',777777,TO_DATE('5-05-2004','DD-MM-YYYY'),1.800,7);
execute altaEmpleado(8,'88888888','Eduardo','Alcantara 8, Malaga',888888,TO_DATE('6-06-2004','DD-MM-YYYY'),1.800,8);
execute altaEmpleado(9,'99999999','Alberto','Elvira 15, Granada',999999,TO_DATE('5-09-2005','DD-MM-YYYY'),1.800,9);
execute altaEmpleado(10,'10101010','Aureliana','Rosas 2, Almeria',101010,TO_DATE('4-10-2002','DD-MM-YYYY'),1.800,10);
execute altaEmpleado(11,'01010101','Manuel','Santa Cruz 13 Sevilla',010101,TO_DATE('6-07-2001','DD-MM-YYYY'),1.500,3);
execute altaEmpleado(12,'12121212','Emilio','Gran Capitan 12, Cordoba',121212,TO_DATE('5-11-2003','DD-MM-YYYY'),1.500,4);
execute altaEmpleado(13,'13131313','Patricia','Rosario 50, Jaen',131313,TO_DATE('4-12-2004','DD-MM-YYYY'),1.500,5);
execute altaEmpleado(14,'14141414','Ines','Constitucion 4, Granada',141414,TO_DATE('7-03-2003','DD-MM-YYYY'),1.500,6);
execute altaEmpleado(15,'15151515','Carlos','Canales 1, Almeria',151515,TO_DATE('16-06-2004','DD-MM-YYYY'),1.500,7);
execute altaEmpleado(16,'16161616','Dolores','Larios 5, Malaga',161616,TO_DATE('14-05-2003','DD-MM-YYYY'),1.500,8);
execute altaEmpleado(17,'17171717','Elias','Mendoza 9, Huelva',171717,TO_DATE('13-06-2004','DD-MM-YYYY'),1.500,1);
execute altaEmpleado(18,'18181818','Concepcion','Canasteros 8, Cadiz',181818,TO_DATE('18-08-2005','DD-MM-YYYY'),1.500,2);
execute altaEmpleado(19,'19191919','Gabriel','Colon 11, Granada',191919,TO_DATE('19-09-2000','DD-MM-YYYY'),1.500,9);
execute altaEmpleado(20,'20202020','Octavio','Las Peñas 18, Almeria',202020,TO_DATE('20-10-2002','DD-MM-YYYY'),1.500,10);

COMMIT;


-- Directores
execute cambiarDirector(1,1);
execute cambiarDirector(2,2);
execute cambiarDirector(3,3);
execute cambiarDirector(4,4);
execute cambiarDirector(5,5);
execute cambiarDirector(6,6);
execute cambiarDirector(7,7);
execute cambiarDirector(8,8);
execute cambiarDirector(9,9);
execute cambiarDirector(10,10);

COMMIT;


-- Proveedores
execute altaProveedor(1,'Gravilla','Sevilla');
execute altaProveedor(2,'VictorLucas','Sevilla');
execute altaProveedor(3,'Pescaveja','Granada');
execute altaProveedor(4,'Molinez','Granada');
COMMIT;

-- Articulos y gestiona
execute altaArticulo(1,'Pollo','A',2);
execute altaArticulo(1,'Pollo','A',3);
execute altaArticulo(2,'Pavo','A',2);
execute altaArticulo(2,'Pavo','A',3);
execute altaArticulo(3,'Ternera','A',2);
execute altaArticulo(3,'Ternera','A',3);
execute altaArticulo(4,'Cordero','A',2);
execute altaArticulo(4,'Cordero','A',3);
execute altaArticulo(5,'Cerdo','A',2);
execute altaArticulo(5,'Cerdo','A',3);
execute altaArticulo(6,'Verdura','B',1);
execute altaArticulo(6,'Verdura','B',4);
execute altaArticulo(7,'Fruta','B',1);
execute altaArticulo(7,'Fruta','B',4);
execute altaArticulo(8,'Legumbre','B',1);
execute altaArticulo(8,'Legumbre','B',4);
execute altaArticulo(9,'Leche','C',1);
execute altaArticulo(9,'Leche','C',4);
execute altaArticulo(10,'Queso','C',1);
execute altaArticulo(10,'Queso','C',4);
execute altaArticulo(11,'Mantequilla','C',1);
execute altaArticulo(11,'Mantequilla','C',4);
execute altaArticulo(12,'Bacalao','D',2);
execute altaArticulo(12,'Bacalao','D',3);
execute altaArticulo(13,'Pulpo','D',2);
execute altaArticulo(13,'Pulpo','D',3);
execute altaArticulo(14,'Pescadilla','D',2);
execute altaArticulo(14,'Pescadilla','D',3);
execute altaArticulo(15,'Calamar','D',2);
execute altaArticulo(15,'Calamar','D',3);

COMMIT;


-- Suministros
execute altaActualizaSuministro(6,1,1,TO_DATE('20-05-2014','DD-MM-YYYY'),200,2);
execute altaActualizaSuministro(10,1,1,TO_DATE('21-05-2014','DD-MM-YYYY'),300,20);
execute altaActualizaSuministro(11,1,2,TO_DATE('13-05-2014','DD-MM-YYYY'),100,20);
execute altaActualizaSuministro(7,1,4,TO_DATE('15-05-2014','DD-MM-YYYY'),500,15);
execute altaActualizaSuministro(1,2,3,TO_DATE('10-05-2014','DD-MM-YYYY'),500,5);
execute altaActualizaSuministro(3,2,3,TO_DATE('15-05-2014','DD-MM-YYYY'),400,20);
execute altaActualizaSuministro(12,2,3,TO_DATE('7-05-2014','DD-MM-YYYY'),200,10);
execute altaActualizaSuministro(13,2,2,TO_DATE('12-05-2014','DD-MM-YYYY'),200,15);
execute altaActualizaSuministro(14,3,5,TO_DATE('17-05-2014','DD-MM-YYYY'),150,20);
execute altaActualizaSuministro(14,3,5,TO_DATE('15-06-2014','DD-MM-YYYY'),100,25);
execute altaActualizaSuministro(4,3,6,TO_DATE('16-05-2014','DD-MM-YYYY'),200,15);
execute altaActualizaSuministro(1,3,7,TO_DATE('20-05-2014','DD-MM-YYYY'),300,5);
execute altaActualizaSuministro(2,3,7,TO_DATE('19-05-2014','DD-MM-YYYY'),100,10);
execute altaActualizaSuministro(9,4,8,TO_DATE('15-05-2014','DD-MM-YYYY'),600,1);
execute altaActualizaSuministro(10,4,9,TO_DATE('13-05-2014','DD-MM-YYYY'),200,20);
--Tiene que fallar porque se le baja el precio:--
execute altaActualizaSuministro(11,4,10,TO_DATE('27-05-2014','DD-MM-YYYY'),200,15);
execute altaActualizaSuministro(8,4,8,TO_DATE('23-05-2014','DD-MM-YYYY'),150,2);
COMMIT;

-- Clientes
execute nuevoCliente(1,'12345678','Jose',123456);
execute nuevoCliente(2,'89012345','Francisco',890123);
execute nuevoCliente(3,'56789012','Maria',567890);
execute nuevoCliente(4,'34567890','Cristina',345678);
execute nuevoCliente(5,'01234567','Carmen',012345);
execute nuevoCliente(6,'78901234','Juan',789012);
execute nuevoCliente(7,'45678901','Miguel',456789);
execute nuevoCliente(8,'23456789','Virtudes',234567);
execute nuevoCliente(9,'22334455','Ignacio',223344);
execute nuevoCliente(10,'66778899','Ismael',667788);


COMMIT;

-- Reservas
execute actualizarReserva(1,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(1,4,'Sencilla',90,TO_DATE('1-10-2014','DD-MM-YYYY'),TO_DATE('6-10-2014','DD-MM-YYYY'));
execute actualizarReserva(1,6,'Doble',100,TO_DATE('5-11-2014','DD-MM-YYYY'),TO_DATE('12-11-2014','DD-MM-YYYY'));
execute actualizarReserva(2,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(3,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(3,9,'Sencilla',150,TO_DATE('1-06-2014','DD-MM-YYYY'),TO_DATE('9-06-2014','DD-MM-YYYY'));
execute actualizarReserva(4,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(4,6,'Doble',90,TO_DATE('30-11-2014','DD-MM-YYYY'),TO_DATE('5-12-2014','DD-MM-YYYY'));
execute actualizarReserva(5,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(6,6,'Doble',110,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
execute actualizarReserva(7,10,'Doble',95,TO_DATE('20-06-2014','DD-MM-YYYY'),TO_DATE('1-07-2014','DD-MM-YYYY'));
execute actualizarReserva(8,2,'Doble',85,TO_DATE('1-06-2014','DD-MM-YYYY'),TO_DATE('15-06-2014','DD-MM-YYYY'));
execute actualizarReserva(9,8,'Doble',120,TO_DATE('1-08-2014','DD-MM-YYYY'),TO_DATE('16-08-2014','DD-MM-YYYY'));
execute actualizarReserva(9,1,'Sencilla',80,TO_DATE('13-09-2014','DD-MM-YYYY'),TO_DATE('25-09-2014','DD-MM-YYYY'));
execute actualizarReserva(10,7,'Doble',75,TO_DATE('1-09-2014','DD-MM-YYYY'),TO_DATE('12-09-2014','DD-MM-YYYY'));

COMMIT;

-------------------------------------------------------------------------------------------------
--Funciona:
execute bajaEmpleado(1);
--No funciona:
--execute bajaEmpleado(21);

-------------------------------------------------------------------------------------------------
--Funciona:
execute modificarSalario(2, 2.000);
--No funciona (se lo disminuimos)
--execute modificarSalario(3, 1.500);

-------------------------------------------------------------------------------------------------
--Funciona:
execute trasladarEmpleado(20,5,'Direccion1',999887766);
execute trasladarEmpleado(20,4,'Direccion2');
execute trasladarEmpleado(20,3);
--No funciona (lo llevamos a un hotel inexistente):
--execute trasladarEmpleado(20,40,'Direccion1',999887766);

-------------------------------------------------------------------------------------------------
--Funciona:
execute anularReserva(1,6,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));
--No funciona (anulamos una reserva que no existe)
execute anularReserva(1,5,TO_DATE('20-07-2014','DD-MM-YYYY'),TO_DATE('31-07-2014','DD-MM-YYYY'));

-------------------------------------------------------------------------------------------------
--Funciona:
execute bajaProveedor(1);
--No funciona (este proveedor no existe):
execute bajaProveedor(15);

-------------------------------------------------------------------------------------------------
--Funciona:
execute bajaSuministros(1,1,6,TO_DATE('20-05-2014','DD-MM-YYYY'));
--No funciona(no existe)
execute bajaSuministros(1,1,6,TO_DATE('20-05-9014','DD-MM-YYYY'));

-------------------------------------------------------------------------------------------------
--Funciona:
execute bajaArticulo(1);
--No funciona(no existe)
execute bajaArticulo(100);