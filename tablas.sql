CREATE TABLE cliente(
	idCliente NUMBER,
	dni CHAR(9) UNIQUE,
	nombre VARCHAR(50),
	telefono NUMBER,
	PRIMARY KEY(idCliente)
);

CREATE TABLE empleado(
	idEmpleado NUMBER,
	idHotel NUMBER  NOT NULL REFERENCES hotel(idHotel),
	salario NUMBER,
	dni CHAR(9) UNIQUE,
	nombre VARCHAR(50),
	telefono NUMBER,
	direccion VARCHAR(100),
	fechaContrato DATE,
	PRIMARY KEY(idEmpleado)
);

CREATE TABLE hotel (
  	idHotel NUMBER,
  	nombre VARCHAR2(50),
  	ciudad VARCHAR2(50) CHECK (ciudad IN ('Huelva','Sevilla','Cádiz','Málaga','Córdoba','Jaen','Granada','Almería')),
  	sencillasLibres NUMBER,
  	doblesLibres NUMBER,
  	idDirector NUMBER NOT NULL REFERENCES empleado(idEmpleado),
  	PRIMARY KEY(idHotel)
);

CREATE TABLE proveedor (
  	idProveedor NUMBER,
  	nombre VARCHAR2(50),
  	ciudad VARCHAR2(50) CHECK (provincia IN ('Granada','Sevilla')),
  	PRIMARY KEY(idProveedor)
);

CREATE TABLE articulo (
  	idArticulo NUMBER,
  	nombre VARCHAR2(50),
  	tipo CHAR(1) CHECK (tipo IN ('A','B','C','D')), -- enumerado A,B,C,D
  	PRIMARY KEY(idArticulo)
);

CREATE TABLE reserva(
	idCliente NUMBER REFERENCES cliente(idCliente),
	fechaEntrada DATE,
	fechaSalida DATE CHECK (fechaInicio <= fechaFin),
	idHotel NUMBER NOT NULL REFERENCES hotel(idHotel),
	precioNoche NUMBER,
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Simple','Doble'),
	PRIMARY KEY(codC,fechaEntrada,fechaSalida)
);

CREATE TABLE tiene (
  	idProveedor NUMBER REFERENCES proveedor(idProveedor),
  	idArticulo NUMBER REFERENCES articulo(idArticulo),
  	PRIMARY KEY(idProveedor,idArticulo)
);

CREATE TABLE suministro (
  	idHotel NUMBER REFERENCES hotel(idHotel),
  	fecha DATE,
  	idProveedor NUMBER,
  	idArticulo NUMBER,
  	cantidad NUMBER,
  	precioUnidad NUMBER,
  	PRIMARY KEY(idHotel,fecha,idProveedor,idArticulo)
  	FOREIGN KEY(idProveedor,idArticulo) REFERENCES tiene(idProveedor,idArticulo)
);

--PERMISOS MAGNOS1--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos2,Magnos3,Magnos4 ON fragmentoSuministro;

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