-- Borramos las tablas y las vistas antes para voler a crearlas todas --
DROP TABLE fragmentoReserva;
DROP TABLE fragmentoTrabaja;
DROP TABLE fragmentoHotel;
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
  	ciudad VARCHAR2(50) CHECK (ciudad IN ('Huelva','Sevilla','Cádiz','Málaga','Córdoba','Jaen','Granada','Almería')),
  	sencillasLibres NUMBER,
  	doblesLibres NUMBER,
  	idDirector NUMBER NOT NULL REFERENCES empleado(idEmpleado) UNIQUE,
  	PRIMARY KEY(idHotel)
);

CREATE TABLE fragmentoTrabaja(
  idEmpleado NUMBER NOT NULL REFERENCES empleado(idEmpleado),
  idHotel NUMBER NOT NULL REFERENCES hotel(idHotel)
  PRIMARY KEY(idEmpleado)
);

CREATE TABLE fragmentoReserva(
	idCliente NUMBER REFERENCES cliente(idCliente),
	fechaEntrada DATE,
	fechaSalida DATE,
	idHotel NUMBER NOT NULL REFERENCES hotel(idHotel),
	precioNoche NUMBER,
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Simple','Doble')),
	PRIMARY KEY(idCliente,fechaEntrada,fechaSalida)
);

-- Descomentar lo siguiente en M2-Granada, M4-Sevilla
/*

DROP TABLE fragmentoSuministro;
DROP TABLE fragmentoTiene;
DROP TABLE articulo;
DROP TABLE fragmentoProveedor;

CREATE TABLE fragmentoProveedor (
  	idProveedor NUMBER,
  	nombre VARCHAR2(50),
  	ciudad VARCHAR2(50) CHECK (ciudad IN ('Granada','Sevilla')),
  	PRIMARY KEY(idProveedor)
);

CREATE TABLE articulo (
  	idArticulo NUMBER,
  	nombre VARCHAR2(50),
  	tipo CHAR(1) CHECK (tipo IN ('A','B','C','D')), -- enumerado A,B,C,D
  	PRIMARY KEY(idArticulo)
);

CREATE TABLE fragmentoTiene (
  	idProveedor NUMBER REFERENCES proveedor(idProveedor),
  	idArticulo NUMBER REFERENCES articulo(idArticulo),
  	PRIMARY KEY(idProveedor,idArticulo)
);

CREATE TABLE fragmentoSuministro (
  	idHotel NUMBER REFERENCES hotel(idHotel),
  	fecha DATE,
  	idProveedor NUMBER,
  	idArticulo NUMBER,
  	cantidad NUMBER,
  	precioUnidad NUMBER,
  	PRIMARY KEY(idHotel,fecha,idProveedor,idArticulo),
  	FOREIGN KEY(idProveedor,idArticulo) REFERENCES tiene(idProveedor,idArticulo)
);

*/
