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
  	ciudad VARCHAR2(50) CHECK (ciudad IN ('Granada','Sevilla')),
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
	fechaSalida DATE,
	idHotel NUMBER NOT NULL REFERENCES fragmentoHotel(idHotel),
	precioNoche NUMBER,
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Simple','Doble')),
  PRIMARY KEY(idCliente,fechaEntrada,fechaSalida)
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
