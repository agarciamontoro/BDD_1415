-- Borramos las tablas y las vistas antes para voler a crearlas todas --
DROP TABLE fragmentoSuministro;
DROP TABLE fragmentoTiene;
DROP TABLE fragmentoReserva;
DROP TABLE fragmentoArticulo;
DROP TABLE fragmentoProveedor;
DROP TABLE fragmentoTrabaja;
DROP TABLE fragmentoHotel;
DROP TABLE fragmentoEmpleado;
DROP TABLE fragmentoCliente;
/*
DROP VIEW suministro;
DROP VIEW tiene;
DROP VIEW reserva;
DROP VIEW proveedor;
DROP VIEW hotel;
DROP VIEW empleado;
*/

--  Tablas  --
CREATE TABLE fragmentoCliente(
	idCliente NUMBER,
	dni CHAR(9) UNIQUE,
	nombre VARCHAR(50),
	telefono NUMBER,
	PRIMARY KEY(idCliente)
);

CREATE TABLE fragmentoEmpleado(
	idEmpleado NUMBER,
	salario NUMBER,
	dni CHAR(9) UNIQUE,
	nombre VARCHAR(50),
	telefono NUMBER,
	direccion VARCHAR(100),
	fechaContrato DATE,
	PRIMARY KEY(idEmpleado)
);

CREATE TABLE fragmentoHotel (
  	idHotel NUMBER,
  	nombre VARCHAR2(50),
  	ciudad VARCHAR2(50) CHECK (ciudad IN ('Huelva','Sevilla','Cádiz','Málaga','Córdoba','Jaen','Granada','Almería')),
  	sencillasLibres NUMBER,
  	doblesLibres NUMBER,
  	idDirector NUMBER NOT NULL REFERENCES fragmentoEmpleado(idEmpleado),
  	PRIMARY KEY(idHotel)
);

CREATE TABLE fragmentoTrabaja(
  idEmpleado NUMBER NOT NULL REFERENCES fragmentoEmpleado(idEmpleado),
  idHotel NUMBER NOT NULL REFERENCES fragmentoHotel(idHotel)
);

CREATE TABLE fragmentoProveedor (
  	idProveedor NUMBER,
  	nombre VARCHAR2(50),
  	ciudad VARCHAR2(50) CHECK (provincia IN ('Granada','Sevilla')),
  	PRIMARY KEY(idProveedor)
);

CREATE TABLE fragmentoArticulo (
  	idArticulo NUMBER,
  	nombre VARCHAR2(50),
  	tipo CHAR(1) CHECK (tipo IN ('A','B','C','D')), -- enumerado A,B,C,D
  	PRIMARY KEY(idArticulo)
);

CREATE TABLE fragmentoReserva(
	idCliente NUMBER REFERENCES fragmentoCliente(idCliente),
	fechaEntrada DATE,
	fechaSalida DATE CHECK (fechaInicio <= fechaFin),
	idHotel NUMBER NOT NULL REFERENCES fragmentoHotel(idHotel),
	precioNoche NUMBER,
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Simple','Doble')),
  PRIMARY KEY(codC,fechaEntrada,fechaSalida)
);

CREATE TABLE fragmentoTiene (
  	idProveedor NUMBER REFERENCES fragmentoProveedor(idProveedor),
  	idArticulo NUMBER REFERENCES fragmentoArticulo(idArticulo),
  	PRIMARY KEY(idProveedor,idArticulo)
);

CREATE TABLE fragmentoSuministro (
  	idHotel NUMBER REFERENCES fragmentoHotel(idHotel),
  	fecha DATE,
  	idProveedor NUMBER,
  	idArticulo NUMBER,
  	cantidad NUMBER,
  	precioUnidad NUMBER,
  	PRIMARY KEY(idHotel,fecha,idProveedor,idArticulo),
  	FOREIGN KEY(idProveedor,idArticulo) REFERENCES fragmentoTiene(idProveedor,idArticulo)
);


--PERMISOS MAGNOS1--
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoEmpleado TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoHotel TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoProveedor TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoReserva TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoTiene TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoSuministro TO Magnos2,Magnos3,Magnos4 ;
/*
--PERMISOS MAGNOS2--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoSuministro;

--PERMISOS MAGNOS3--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoSuministro;

--PERMISOS MAGNOS4--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoSuministro;

--  Vistas  --

CREATE VIEW empleado AS
  SELECT * FROM Magnos1.fragmentoEmpleado
  UNION
  SELECT * FROM Magnos2.fragmentoEmpleado
  UNION
  SELECT * FROM Magnos3.fragmentoEmpleado
  UNION
  SELECT * FROM Magnos4.fragmentoEmpleado;

CREATE VIEW hotel AS 
  SELECT * FROM Magnos1.fragmentoHotel
  UNION
  SELECT * FROM Magnos2.fragmentoHotel
  UNION 
  SELECT * FROM Magnos3.fragmentoHotel
  UNION
  SELECT * FROM Magnos4.fragmentoHotel;

CREATE VIEW proveedor AS
  SELECT * FROM Magnos1.fragmentoProveedor
  UNION
  SELECT * FROM Magnos2.fragmentoProveedor
  UNION
  SELECT * FROM Magnos3.fragmentoProveedor
  UNION
  SELECT * FROM Magnos4.fragmentoProveedor;

CREATE VIEW reserva AS
  SELECT * FROM Magnos1.fragmentoReserva
  UNION
  SELECT * FROM Magnos2.fragmentoReserva
  UNION
  SELECT * FROM Magnos3.fragmentoReserva
  UNION
  SELECT * FROM Magnos4.fragmentoReserva;

CREATE VIEW tiene AS
  SELECT * FROM Magnos1.fragmentoTiene
  UNION
  SELECT * FROM Magnos2.fragmentoTiene
  UNION
  SELECT * FROM Magnos3.fragmentoTiene
  UNION
  SELECT * FROM Magnos4.fragmentoTiene;

CREATE VIEW suministro AS
  SELECT * FROM Magnos1.fragmentoSuministro
  UNION
  SELECT * FROM Magnos2.fragmentoSuministro
  UNION
  SELECT * FROM Magnos3.fragmentoSuministro
  UNION
  SELECT * FROM Magnos4.fragmentoSuministro;*/