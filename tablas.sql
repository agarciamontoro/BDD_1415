-- Borramos las tablas y las vistas antes para voler a crearlas todas --

-- Descomentar lo siguiente en M2-Granada, M4-Sevilla
/*
DROP VIEW suministro;
DROP TABLE fragmentoSuministro;

DROP VIEW tiene;
DROP TABLE fragmentoTiene;

DROP VIEW articulo;
DROP TABLE articulo;

DROP VIEW proveedor;
DROP TABLE fragmentoProveedor;
*/

DROP VIEW reserva;
DROP TABLE fragmentoReserva;

DROP VIEW trabaja;
DROP TABLE fragmentoTrabaja;

DROP VIEW hotel;
DROP TABLE fragmentoHotel;

DROP VIEW empleado;
DROP TABLE fragmentoEmpleado;

DROP TABLE cliente;


--  Tablas  --
CREATE TABLE cliente(
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

-- El UNIQUE en idDirector es para la restricción 8
CREATE TABLE fragmentoHotel (
  	idHotel NUMBER,
  	nombre VARCHAR2(50),
  	provincia VARCHAR2(50) CHECK (provincia IN ('Huelva','Sevilla','Cadiz','Malaga','Cordoba','Jaen','Granada','Almeria')),
    ciudad VARCHAR2(50),
  	sencillasLibres NUMBER,
  	doblesLibres NUMBER,
  	idDirector NUMBER UNIQUE,
  	PRIMARY KEY(idHotel)
);

CREATE TABLE fragmentoTrabaja(
  idEmpleado NUMBER NOT NULL REFERENCES fragmentoEmpleado(idEmpleado),
  idHotel NUMBER NOT NULL REFERENCES fragmentoHotel(idHotel),
  PRIMARY KEY(idEmpleado)
);

CREATE TABLE fragmentoReserva(
	idCliente NUMBER REFERENCES cliente(idCliente),
	fechaEntrada DATE,
	fechaSalida DATE,
	idHotel NUMBER NOT NULL REFERENCES fragmentoHotel(idHotel),
	precioNoche NUMBER,
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Simple','Doble')),
	PRIMARY KEY(idCliente,fechaEntrada,fechaSalida)
);

-- Descomentar lo siguiente en M2-Granada, M4-Sevilla
/*
CREATE TABLE fragmentoProveedor (
  	idProveedor NUMBER,
  	nombre VARCHAR2(50),
  	provincia VARCHAR2(50) CHECK (provincia IN ('Granada','Sevilla')),
  	PRIMARY KEY(idProveedor)
);

CREATE TABLE articulo (
  	idArticulo NUMBER,
  	nombre VARCHAR2(50),
  	tipo CHAR(1) CHECK (tipo IN ('A','B','C','D')), -- enumerado A,B,C,D
  	PRIMARY KEY(idArticulo)
);

CREATE TABLE fragmentoTiene (
  	idProveedor NUMBER REFERENCES fragmentoProveedor(idProveedor),
  	idArticulo NUMBER REFERENCES articulo(idArticulo),
  	PRIMARY KEY(idProveedor,idArticulo)
);

CREATE TABLE fragmentoSuministro (
  	idHotel,
  	fecha DATE,
  	idProveedor NUMBER,
  	idArticulo NUMBER,
  	cantidad NUMBER,
  	precioUnidad NUMBER,
  	PRIMARY KEY(idHotel,fecha,idProveedor,idArticulo),
  	FOREIGN KEY(idProveedor,idArticulo) REFERENCES fragmentoTiene(idProveedor,idArticulo)
);
*/
