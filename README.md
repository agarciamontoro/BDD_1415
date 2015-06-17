# Diseño conceptual y lógico de la base de datos
## Diagrama entidad-relación
El diagrama de entidad-relación resultante del análisis del enunciado es el siguiente:

![Diagrama E-R](https://github.com/agarciamontoro/BDD_1415/blob/master/Diagramas/EntidadRelacion.png)

### Alternativas
**Modelar director como una entidad hija de empleado**

No se necesitaba el potencial de modelar como otra entidad diferente, por otra parte hubiera complicado el diagrama.

**Provincia como entidad**

Se pensó hacerlo como entidad porque se tenía un grupo fijo de provincias, que aparecían por todo el diagrama, pero realmente solo se usarían las provincias a la hora de fragmentar, así que por simpleza se decidió modelarlas como atributo.

**Habitación como entidad débil de hotel**

No se necesitaba el potencial que da una entidad en este caso, así que para simplificarlo todo se decidió dejarlo como atributo.

**Agregación**

En vez de haber hecho uso de una agregación para relacionar el **Proveedor**, **Artículo** y **Suministro**, se podría haber optado por una *relación ternaria*. Pero pueden llegar a ser difíciles de entender. Además se llegó a la conclusión de que la agregación optimizaba mejor el problema planteado.
### Paso a tablas
Las tablas resultantes del diagrama anterior son las siguientes:

* **Cliente** (_idCliente_, DNI, nombre, telefono)
* **Empleado** (_idEmpleado_, salario, DNI, nombre, telefono, direccion, fechaContrato)
* **Hotel** (_idHotel_, nombre, provincia, ciudad, sencillasLibres, doblesLibres)
* **Proveedor** (_idProveedor_, nombre, provincia)
* **Articulo** (_idArticulo_, nombre, tipo)
* **Reserva** (_idCliente, fechaEntrada, fechaSalida_, idHotel, precioNoche, tipoHabitacion )
* **Dirige** (_idEmpleado_, idHotel)
* **Trabaja** (_idEmpleado_, idHotel)
* **Tiene** (_idProveedor, idArticulo_)
* **Suministro** (_idHotel, fecha, idProveedor, idArticulo_, cantidad, precioUnidad)

### Alternativas
Con respecto a la propagación de llaves de tablas, se consideraron dos escenarios:

* El primero consistía en unir las tablas **Trabaja** y **Empleado** por un lado y **Dirige** y **Hotel** por otro.
* El segundo consistía únicamente en unir sólo una de las dos parejas anteriores.

La implementación de la primera de las opciones conllevaba bucles de referencias que no podían ser solucionados, así que finalmente se optó por la unión de sólo una de las dos parejas de tablas antes referidas. Tras propagar las llaves de **Dirige** en la tabla **Hotel**, el conjunto de tablas resultantes es el siguiente:

* **Cliente** (_idCliente_, DNI, nombre, telefono)
* **Empleado** (_idEmpleado_, salario, DNI, nombre, telefono, direccion, fechaContrato)
* **Hotel** (_idHotel_, nombre, provincia, sencillasLibres, doblesLibes, idDirector)
* **Proveedor** (_idProveedor_, nombre, provincia)
* **Articulo** (_idArticulo_, nombre, tipo)
* **Reserva** (_idCliente, fechaEntrada, fechaSalida_, idHotel, precioNoche, tipoHabitacion, )
* **Trabaja** (_idEmpleado_, idHotel)
* **Tiene** (_idProveedor, idArticulo_)
* **Suministro** (_idHotel, fecha, idProveedor, idArticulo_, cantidad, precioUnidad)


## Diseño de la fragmentación y de la asignación
### Introducción
La base de datos distribuida tendrá sus datos físicos almacenados en cuatro localidades: **Granada, Cádiz, Sevilla y Málaga**.

Cada una de estas localidades almacenará la información de los siguientes lugares:

1. **Granada** = Granada y Jaén
2. **Cádiz** = Cádiz y Huelva
3. **Sevilla** = Sevilla y Córdoba
4. **Málaga** = Málaga y Almería

Ahora, basándose en el diagrama *Entidad Relación* realizado anteriormente y estos datos, se hace la fragmentación.

### Fragmentación
#### Tablas a fragmentar.
La fragmentación se realizará en dos pasos:

1. Fragmentaciones horizontales primarias de aquellas tablas cuyas tuplas tengan una relación directa con la localidad en la que se encuentran.
2. Fragmentaciones horizontales, derivadas de las anteriores, de aquellas tablas que tengan una relación directa con los fragmentos. Tendremos en consideración el *grado de relación* de las tuplas con la localidad, de manera que en cada caso se decidirá entre **fragmentación** o **replicación**.

#### Fragmentaciones horizontales primarias
Las dos únicas tablas cuyas tuplas tienen una relación directa -mediante un atributo de las mismas- de la localidad en la que se encuentran son **Hotel** y **Proveedor**.

Es claro entonces que la fragmentación hay que realizarla en base al atributo *provincia* de las mismas. Esta decisión tiene como principal objetivo maximizar los accesos locales: los accesos que involucren a las tablas **Hotel** y **Proveedor** se realizarán, en su mayoría, desde las ciudades cuyas tuplas se necesita consultar.

#### Hotel

Predicados simples:

    P = { Provincia = Granada, Provincia = Jaén, Provincia = Cádiz,
      Provincia = Huelva, Provincia = Sevilla, Provincia = Córdoba,
      Provincia = Málaga, Provincia = Almería } }

Para facilitarnos la tarea, notemos cada predicado.

1. Pgra = Provincia = Granada
2. Pjae = Provincia = Jaén
3. Pcad = Provincia = Cádiz
4. Phue = Provincia = Huelva
5. Psev = Provincia = Sevilla
6. Pcor = Provincia = Córdoba
7. Pmal = Provincia = Málaga
8. Palm = Provincia = Añmería

Los predicados verdaderos:

1. y1 =   Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
2. y2 =  ¬Pgra ^  Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
3. y3 =  ¬Pgra ^ ¬Pjae ^  Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
4. y4 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^  Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
5. y5 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^  Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
6. y6 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^  Pcor ^ ¬Pmal ^ ¬Palm
7. y7 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^  Pmal ^ ¬Palm
8. y8 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^  Palm

Entonces nos da como resultado 8 fragmentos:

1. Hotel1 = SL1(Hotel)
2. Hotel2 = SL2(Hotel)
3. Hotel3 = SL3(Hotel)
4. Hotel4 = SL4(Hotel)
5. Hotel5 = SL5(Hotel)
6. Hotel6 = SL6(Hotel)
7. Hotel7 = SL7(Hotel)
8. Hotel8 = SL8(Hotel)

Entonces se hace la asignación de tal forma que se adapte a la representación física que se proporciona

1. Granada: Hotel1,Hotel2
2. Cádiz: Hotel3,Hotel4
3. Sevilla: Hotel5,Hotel6
4. Málaga: Hotel7,Hotel8

#### Proveedor

Los proveedores de la cadena están todos en *Granada* y en *Sevilla*, de manera que su área de acción es la siguiente:

Proveedores en *Granada*: Suministran a Granada, Jaén, Málaga y Almería.

Proveedores en *Sevilla*: Suministran a Sevilla, Córdoba, Cádiz y Huelva.

Predicados simples:

    P = { Provincia = Granada, Provincia = Sevilla }

Para facilitarnos la tarea, notemos cada predicado.

1. Pgra = Provincia = Granada
2. Psev = Provincia = Sevilla

Los predicados verdaderos:

1. y1 =   Pgra ^ ¬Psev
2. y2 =  ¬Pgra ^ Psev

Resultan entonces 2 fragmentos:

1. Proveedor1 = SL1(Proveedor)
2. Proveedor2 = SL2(Proveedor)

La asignación de los fragmentos se hace de tal forma que se adapte a la representación física que se proporciona:

1. Granada: Proveedor1
2. Sevilla: Proveedor2

#### Fragmentaciones horizontales derivadas

Derivadas de las fragmentaciones anteriormente realizadas, a continuación se presentan las fragmentaciones de tablas que, si bien no tienen un atributo *provincia* explícito, tienen una relación indirecta con la provincia en la que se encuentran. Estas tablas son:

* Empleado
* Tabla
* Reserva
* Suministro
* Tiene

El objetivo de estas fragmentaciones horizontales derivadas es, igual que en las anteriores, maximizar los accesos locales; es lícito suponer que los accesos que involucren a estas tablas en sus consultas se realizarán en su gran mayoría desde las localidades donde se encuentren físicamente sus tuplas.

##### Trabaja
Se hace a partir del Hotel.

Resultan 8 fragmentos:

1. Trabaja1 = Trabaja SJNCodH=CodH Hotel1
2. Trabaja2 = Trabaja SJNCodH=CodH Hotel2
3. Trabaja3 = Trabaja SJNCodH=CodH Hotel3
4. Trabaja4 = Trabaja SJNCodH=CodH Hotel4
5. Trabaja5 = Trabaja SJNCodH=CodH Hotel5
6. Trabaja6 = Trabaja SJNCodH=CodH Hotel6
7. Trabaja7 = Trabaja SJNCodH=CodH Hotel7
8. Trabaja8 = Trabaja SJNCodH=CodH Hotel8

La asignación se hace de la siguiente forma:

1. Granada: Trabaja1, Trabaja2
2. Cádiz: Trabaja3, Trabaja4
3. Sevilla: Trabaja5, Trabaja6
4. Málaga: Trabaja7, Trabaja8

##### Empleado
Se hace a partir de la tabla Trabaja.

Resultan 8 fragmentos:

1. Empleado1 = Empleado SJNCodH=CodH Trabaja1
2. Empleado2 = Empleado SJNCodH=CodH Trabaja2
3. Empleado3 = Empleado SJNCodH=CodH Trabaja3
4. Empleado4 = Empleado SJNCodH=CodH Trabaja4
5. Empleado5 = Empleado SJNCodH=CodH Trabaja5
6. Empleado6 = Empleado SJNCodH=CodH Trabaja6
7. Empleado7 = Empleado SJNCodH=CodH Trabaja7
8. Empleado8 = Empleado SJNCodH=CodH Trabaja8

La asignación se hace de la siguiente forma:

1. Granada: Empleado1, Empleado2
2. Cádiz: Empleado3, Empleado4
3. Sevilla: Empleado5, Empleado6
4. Málaga: Empleado7, Empleado8

##### Reserva
Se hace a partir del Hotel.

Resultan 8 fragmentos:

1. Reserva1 = Reserva SJNCodH=CodH Hotel1
2. Reserva2 = Reserva SJNCodH=CodH Hotel2
3. Reserva3 = Reserva SJNCodH=CodH Hotel3
4. Reserva4 = Reserva SJNCodH=CodH Hotel4
5. Reserva5 = Reserva SJNCodH=CodH Hotel5
6. Reserva6 = Reserva SJNCodH=CodH Hotel6
7. Reserva7 = Reserva SJNCodH=CodH Hotel7
8. Reserva8 = Reserva SJNCodH=CodH Hotel8

La asignación se hace de la siguiente forma:

1. Granada: Reserva1, Reserva2
2. Cádiz: Reserva3, Reserva4
3. Sevilla: Reserva5, Reserva6
4. Málaga: Reserva7, Reserva8


##### Suministro
se hace a partir de Proveedor

Resultan 8 fragmentos:

1. Suministro1 = Suministro SJNCodH=CodH Proveedor1
2. Suministro2 = Suministro SJNCodH=CodH Proveedor2

La asignación se hace de la siguiente forma:

1. Granada: Suministro1
2. Sevilla: Suministro2

##### Tiene
se hace a partir de Proveedor.

Resultan 2 fragmentos:

1. Tiene1 = Tiene SJNCodH=CodH Proveedor1
2. Tiene2 = Tiene SJNCodH=CodH Proveedor2

La asignación se hace de la siguiente forma:

1. Granada: Tiene1
2. Sevilla: Tiene2

#### Replicaciones

Las dos tablas restantes, **Cliente** y **Artículo**, no tienen una relación directa ni indirecta con la provincia. Se podría entonces optar por la asignación de todas las tuplas a una sola localidad o por la réplica de los datos en todas ellas.

Se puede suponer que la cantidad de actualizaciones de estas dos tablas no es crítica, de manera que es mejor optimizar los accesos locales que las actualizaciones remotas. Por tanto, la réplica es la opción óptima.

##### Cliente
La replicamos en todos los puntos de almacenamiento. Se hace así ya que un cliente no está intrínsicamente relacionado con ninguna zona geográfica.

##### Artículo
La replicamos en los puntos de almacenamiento de los proveedores. Se hace así ya que los artículos no están intrínsicamente relacionados con ninguna zona geográfica, pero sólo serán usados por los proveedores.

#### Alternativas o Justificación
**Hotel**

Se decidió fragmentarlo en cuatro nodos atendiendo a la provincia para mejorar las operaciones locales.

**Dirige, Empleado, Reserva**

Se decidió usar fragmentación horizontal derivdad por **Hotel**, porque se ajustaba mejor al problema.

**Proveedor**

Se decidió fragmentarlo en los dos nodos que toma provincia para mejorar las operaciones locales.

**Tiene**

Se decidió usar fragmentación horizontal derivada por **Proveedor**, porque se ajustaba mejor al problema.

**Cliente**

Como fragmentamos **Reserva**, se planteó fragmentar **Cliente** también.Pero un cliente podía reservar en cualquier sitio, por lo que la replicación en toda la base de datos se ajustaba mejor al problema.

**Articulo**

Como fragmentamos **Tiene**, se planteó fragmentar **Artículo** también. Pero un artículo podía tener varios proveedores de distintas provincias. Así que decidimos replicarlo en dónde estában los proveedores.

**Suministra**

Se decidió fragmentarla en las localidades de **Proveedor**, ya que es más coherente y en la mayoría de los casos optimizaría mejor las consultas. Se pensó también en fragmentarla en las localidades de **Hotel** pero nos pareció que optimizaría menos.

# Implementación
##Creación de tablas

```SQL
-- Borramos las tablas y las vistas antes para voler a crearlas todas --

-- Descomentar lo siguiente en M2-Granada, M4-Sevilla

DROP VIEW suministro;
DROP TABLE fragmentoSuministro;

DROP VIEW tiene;
DROP TABLE fragmentoTiene;

DROP VIEW articulo;
DROP TABLE articulo;

DROP VIEW proveedor;
DROP TABLE fragmentoProveedor;

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
	tipoHabitacion VARCHAR(10) CHECK (tipoHabitacion IN ('Sencilla','Doble')),
	PRIMARY KEY(idCliente,fechaEntrada,fechaSalida)
);

-- Descomentar lo siguiente en M2-Granada, M4-Sevilla
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
  	idHotel NUMBER,
  	fecha DATE,
  	idProveedor NUMBER,
  	idArticulo NUMBER,
  	cantidad NUMBER,
  	precioUnidad NUMBER,
  	PRIMARY KEY(idHotel,fecha,idProveedor,idArticulo),
  	FOREIGN KEY(idProveedor,idArticulo) REFERENCES fragmentoTiene(idProveedor,idArticulo)
);
COMMIT;
```
##Privilegios
```SQL
--PERMISOS MAGNOS1--
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON cliente TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoEmpleado TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoHotel TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTrabaja TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoReserva TO Magnos2,Magnos3,Magnos4 ;
COMMIT;
--PERMISOS MAGNOS2--
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON cliente TO Magnos1,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoEmpleado TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoHotel TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTrabaja TO Magnos1,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoProveedor TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoReserva TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTiene TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoSuministro TO Magnos1,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON articulo TO Magnos1,Magnos3,Magnos4 ;
COMMIT;
--PERMISOS MAGNOS3--
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON cliente TO Magnos1,Magnos2,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoEmpleado TO Magnos1,Magnos2,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoHotel TO Magnos1,Magnos2,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTrabaja TO Magnos1,Magnos2,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoReserva TO Magnos1,Magnos2,Magnos4 ;
COMMIT;
--PERMISOS MAGNOS4--
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON cliente TO Magnos1,Magnos2,Magnos3;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoEmpleado TO Magnos1,Magnos2,Magnos3;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoHotel TO Magnos1,Magnos2,Magnos3 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTrabaja TO Magnos1,Magnos2,Magnos3;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoProveedor TO Magnos1,Magnos2,Magnos3 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoReserva TO Magnos1,Magnos2,Magnos3 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoTiene TO Magnos1,Magnos2,Magnos3 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON fragmentoSuministro TO Magnos1,Magnos2,Magnos3 ;
GRANT SELECT,UPDATE,DELETE,INSERT,REFERENCES ON articulo TO Magnos1,Magnos2,Magnos3;
COMMIT;
```
##Vistas
```SQL
DROP VIEW suministro;
DROP VIEW tiene;
DROP VIEW reserva;
DROP VIEW proveedor;
DROP VIEW hotel;
DROP VIEW empleado;
DROP VIEW trabaja;

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
  SELECT * FROM Magnos2.fragmentoProveedor
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
  SELECT * FROM Magnos2.fragmentoTiene
  UNION
  SELECT * FROM Magnos4.fragmentoTiene;

CREATE VIEW suministro AS
  SELECT * FROM Magnos2.fragmentoSuministro
  UNION
  SELECT * FROM Magnos4.fragmentoSuministro;

CREATE VIEW trabaja AS
  SELECT * FROM Magnos1.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos2.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos3.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos4.fragmentoTrabaja;

-- Descomentar lo siguiente en M1-Cadiz, M3-Malaga


DROP VIEW articulo;

CREATE VIEW articulo AS
  --SELECT * FROM Magnos2.articulo;
  SELECT * FROM Magnos4.articulo;

COMMIT;
```

##Disparadores
###Inserción
```SQL

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaEmpleado
BEFORE INSERT OR UPDATE ON fragmentoEmpleado
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idEmpleado')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Empleado
     WHERE idEmpleado = :NEW.idEmpleado;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20200,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaHotel
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel')) THEN
    SELECT COUNT(*) INTO numTuplas FROM Hotel
    WHERE idHotel = :NEW.idHotel;
  	IF numTuplas > 0 THEN
    	RAISE_APPLICATION_ERROR(-20201,'Restricción de llave única violada: la llave ya existe en la tabla');
    END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTrabaja
BEFORE INSERT OR UPDATE ON fragmentoTrabaja
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel') OR UPDATING('idEmpleado')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Trabaja
     WHERE idEmpleado = :NEW.idEmpleado;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20202,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaReserva
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idCliente') OR UPDATING('fechaEntrada') OR UPDATING ('fechaSalida')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Reserva
     WHERE idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20203,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/
-- Solo para magnos2 - Granada y magnos4 - Sevilla

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaProveedor
BEFORE INSERT OR UPDATE ON fragmentoProveedor
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idProveedor')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Proveedor
     WHERE idProveedor = :NEW.idProveedor;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20204,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaTiene
BEFORE INSERT OR UPDATE ON fragmentoTiene
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idArticulo') OR UPDATING('idProveedor')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Tiene
     WHERE idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20205,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

-------------------------------------------------------

CREATE OR REPLACE TRIGGER llaveUnicaSuministro
BEFORE INSERT OR UPDATE ON fragmentoSuministro
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
  numTuplas NUMBER;
BEGIN
  IF (INSERTING OR UPDATING('idHotel') OR UPDATING('fecha') OR UPDATING('idProveedor') OR UPDATING('idArticulo')) THEN
     SELECT COUNT(*) INTO numTuplas FROM Suministro
     WHERE idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo;
   	IF numTuplas > 0 THEN
     	RAISE_APPLICATION_ERROR(-20206,'Restricción de llave única violada: la llave ya existe en la tabla');
     END IF;
  END IF;
  COMMIT;
END;
/

COMMIT;

```
###Referencias
```SQL
-- Integridad referencial de idDirector en Hotel con respecto a Empleado --
CREATE OR REPLACE TRIGGER referenciaDirector
BEFORE INSERT OR UPDATE ON fragmentoHotel
FOR EACH ROW
DECLARE
  numEmpleados NUMBER;
BEGIN
  IF :NEW.idDirector IS NOT NULL THEN
	  SELECT COUNT(*) INTO numEmpleados FROM empleado
	  WHERE empleado.idEmpleado = :NEW.idDirector;

	  IF numEmpleados = 0 THEN
	      RAISE_APPLICATION_ERROR(-20300,'Error de integridad referencial: el director especificado no existe en la base de datos');
	  END IF;
   END IF;
END;
/

-- Solo para magnos2 - Granada y magnos4 - Sevilla
-- Integridad referencial de idHotel en Suministro con respecto Hotel --
CREATE OR REPLACE TRIGGER referenciaHotel
BEFORE INSERT OR UPDATE ON fragmentoSuministro
FOR EACH ROW
DECLARE
numHoteles NUMBER;
BEGIN
   IF :NEW.idHotel IS NOT NULL THEN
      SELECT COUNT(*) INTO numHoteles FROM hotel
      WHERE hotel.idHotel = :NEW.idHotel;

      IF numHoteles = 0 THEN
         RAISE_APPLICATION_ERROR(-20301,'Error de integridad referencial: el hotel especificado no existe en la base de datos');
      END IF;
   END IF;
END;
/
COMMIT;
```
###Restricciones
```SQL
-- Restricción 4 --
-- Antes de hacer una nueva reserva contamos el número de reservas que tenemos del tipo de
-- habitacion que queremos insertar. A continuación vemos cuantas habitaciones tiene el
-- hotel del tipo que se quiere añadir una reserva, y en el caso en el que el número de
-- habitaciones de ese tipo sea menor o igual que el número de reservas que se tiene
-- actualmente, lanzamos error, en caso contrario, dejamos que se haga la inserción

CREATE OR REPLACE TRIGGER capacidadReservas
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
  capacidad NUMBER;
  reservasActuales NUMBER;
BEGIN
  SELECT COUNT(*) INTO reservasActuales FROM reserva
  WHERE reserva.idHotel = :NEW.idHotel
    AND reserva.tipoHabitacion = :NEW.tipoHabitacion
    AND (
        (reserva.fechaEntrada BETWEEN :NEW.fechaEntrada AND :NEW.fechaSalida)
        OR
        (reserva.fechaSalida BETWEEN :NEW.fechaSalida AND :NEW.fechaEntrada)
    );

  IF :NEW.tipoHabitacion = 'Sencilla' THEN
    SELECT sencillasLibres INTO capacidad FROM hotel
    WHERE hotel.idHotel = :NEW.idHotel;

    IF capacidad <= reservasActuales THEN
      RAISE_APPLICATION_ERROR(-20101,'Las reservas superan el número de habitaciones sencillas');
    END IF;

  END IF;

  IF :NEW.tipoHabitacion = 'Doble' THEN
    SELECT doblesLibres INTO capacidad FROM hotel
    WHERE hotel.idHotel = :NEW.idHotel;

    IF capacidad <= reservasActuales THEN
      RAISE_APPLICATION_ERROR(-20102,'Las reservas superan el número de habitaciones dobles');
    END IF;

  END IF;

END;
/

-- Restricción 5 --
-- Antes de hacer una nueva reserva, se comprueba que la fecha de entrada sea menor que la de
-- salida, en caso contrario se rechaza la inserción.

CREATE OR REPLACE TRIGGER controlFechasReservas
BEFORE INSERT ON fragmentoReserva
FOR EACH ROW
	WHEN (NEW.fechaEntrada >= NEW.fechaSalida)
BEGIN
  RAISE_APPLICATION_ERROR(-20002,'La fecha de entrada es posterior que la fecha de salida');
END;
/

 -- Restricción 6 --
-- Antes de una nueva reserva, comprobamos que las fechas no se cruzen.

CREATE OR REPLACE TRIGGER controlReservasCliente
BEFORE INSERT OR UPDATE ON fragmentoReserva
FOR EACH ROW
DECLARE
    numReservas NUMBER;
BEGIN
  SELECT COUNT(*) INTO numReservas FROM reserva
  	WHERE :NEW.idCliente = idCliente
  		AND((fechaEntrada >= :NEW.fechaEntrada AND fechaEntrada < :NEW.fechaSalida)
    		OR(fechaSalida <= :NEW.fechaSalida AND fechaSalida > :NEW.fechaEntrada)
  	);

  IF numReservas > 0 THEN
    RAISE_APPLICATION_ERROR(-20003,'El cliente tiene reservas simultáneas en distintos hoteles');
  END IF;
END;
/

-- Restricción 10 --
-- Antes de actualizar la información de un empleado, se comprueba que el nuevo salario
-- no sea menor que el antiguo.

CREATE OR REPLACE TRIGGER salarioEmpleadoNoDisminuye
BEFORE UPDATE OF salario ON fragmentoEmpleado
FOR EACH ROW WHEN (NEW.salario < OLD.salario)
BEGIN
	RAISE_APPLICATION_ERROR(-20004,'El salario no se puede disminuir');
END;
/

-- Sólo ejectar en magnos2 y magnos4
-- Restricción 12 --
-- Antes de hacer un nuevo suministro, vemos el precioUnidad minimo en los suministros
-- del artículo del que se desea hacer un nuevo suministro. En el caso en el que el nuevo
-- precio sea menor que ese mínimo, rechazamos la inserción.

CREATE OR REPLACE TRIGGER precioSuministroNoMenor
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
	precioMinSumAnteriores fragmentoSuministro.precioUnidad%TYPE;
BEGIN
	SELECT MIN(precioUnidad)
    INTO precioMinSumAnteriores
    FROM suministro
	WHERE :NEW.idArticulo = suministro.idArticulo ;

	IF :NEW.precioUnidad < precioMinSumAnteriores THEN
		RAISE_APPLICATION_ERROR(-20005,'El precio por unidad no puede ser menor respecto a otros suministros');
	END IF;

    COMMIT;
END;
/

-- Restricción 13 --
-- Antes de hacer un nuevo suministro, vemos de que provincia es el proveedor, a continuación
-- contamos el número de veces que se ha suministrado ese artículo por los distintos proveedores
-- que trabajan con esas provincias. En caso de ser más de 2 no permitimos el nuevo suministro.

CREATE OR REPLACE TRIGGER suminArticuloMaxDosProv
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    provinciaProveedor fragmentoProveedor.provincia%TYPE;
    nVecesSuministrado NUMBER;
BEGIN
	SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = proveedor.idProveedor;

	CASE provinciaProveedor
        WHEN 'Granada' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suministro, magnos2.fragmentoProveedor
            WHERE (suministro.idProveedor <> :NEW.idProveedor
                  AND suministro.idProveedor = magnos2.fragmentoProveedor.idProveedor
                  AND suministro.idArticulo = :NEW.idArticulo );

        WHEN 'Sevilla' THEN
            SELECT COUNT(*) INTO nVecesSuministrado
            FROM suministro, magnos4.fragmentoProveedor
            WHERE (suministro.idProveedor <> :NEW.idProveedor
                  AND suministro.idProveedor = magnos4.fragmentoProveedor.idProveedor
                  AND suministro.idArticulo = :new.idArticulo );

        ELSE RAISE_APPLICATION_ERROR(-20006, 'Provincia del proveedor errónea');
    END CASE;

	IF nVecesSuministrado > 0 THEN
		RAISE_APPLICATION_ERROR(-20106,'Un artículo sólo puede ser suministrado por dos proveedores distintos');
	END IF;

  COMMIT;
END;
/

-- Restricciones 15 y 16  --
-- Antes de hacer un nuevo suministro, vemos la provincia del proveedor que quiere
-- hacer un nuevo suministro, a contunuación antendiendo a la provincia del proveeedor,
-- comprobamos si el nuevo suministro se quiere hacer a una de las provincias de las que
-- el proveedor no puede suministrar.

CREATE OR REPLACE TRIGGER restriccionHotelesProveedores
BEFORE INSERT ON fragmentoSuministro
FOR EACH ROW
DECLARE
	provinciaProveedor fragmentoProveedor.provincia%TYPE;
	suministrosInvalidos NUMBER;
BEGIN
	SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
	WHERE :NEW.idProveedor = idProveedor;

	IF provinciaProveedor = 'Sevilla' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, hotel
	 	WHERE (:NEW.idHotel = hotel.idHotel
	 		AND hotel.idHotel = suministro.idHotel
	 		AND hotel.provincia IN ('Granada','Jaen','Malaga','Almeria'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20007, 'Las ciudades de Granada, Jaén, Málaga y Almería no pueden tener suministros de Sevilla');
	 	END IF;
	END IF;

	IF provinciaProveedor = 'Granada' THEN
		SELECT COUNT(*)
        INTO suministrosInvalidos
        FROM suministro, hotel
	 	WHERE (:NEW.idHotel = hotel.idHotel
	 		AND hotel.idHotel = suministro.idHotel
	 		AND hotel.provincia IN ('Cordoba','Sevilla','Cadiz','Huelva'));

	 	IF suministrosInvalidos > 0 THEN
	 		RAISE_APPLICATION_ERROR(-20008, 'Las ciudades de Córdoba, Sevilla, Cádiz o Huelva no pueden tener suministros de Granada');
	 	END IF;
	END IF;
END;
/

--Restricción 17 --
-- Antes de borrar un proveedor contamos el número de suministros que ha hecho el proveedor
-- con cantidad mayor que cero, en caso de haber alguno, no se puede eliminar ese proveedor.

 CREATE OR REPLACE TRIGGER borrarProveedor
 BEFORE DELETE ON fragmentoProveedor
 FOR EACH ROW
 DECLARE
 	suministros NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO suministros FROM fragmentoSuministro
 		WHERE :OLD.idProveedor = idProveedor AND cantidad > 0;

 	IF suministros > 0 THEN
 		RAISE_APPLICATION_ERROR(-20009, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;
 /

 --Restricción 18 --
 -- Antes de borrar un artículo se cuenta si existe un suministro con cantidad mayor que cero,
 -- en caso de haber alguno, no se puede eliminar ese artículo.

 CREATE OR REPLACE TRIGGER borrarArticulo
 BEFORE DELETE ON articulo
 FOR EACH ROW
 DECLARE
    suministros NUMBER;
 BEGIN
 	SELECT COUNT(*) INTO suministros FROM fragmentoSuministro
 		WHERE :OLD.idArticulo = idArticulo AND cantidad > 0;

  IF suministros > 0 THEN
 		RAISE_APPLICATION_ERROR(-20010, 'No se puede eliminar, la cantidad suministrada no es 0');
 	END IF;
 END;
/
COMMIT;
```
##Procedimientos
```SQL
-- 1. Dar de alta a un nuevo empleado. --
CREATE OR REPLACE PROCEDURE altaEmpleado(
    arg_idEmpleado    fragmentoEmpleado.idEmpleado%TYPE,
    arg_dni fragmentoEmpleado.dni%TYPE,
    arg_nombre  fragmentoEmpleado.nombre%TYPE,
    arg_direccion    fragmentoEmpleado.direccion%TYPE,
    arg_telefono fragmentoEmpleado.telefono%TYPE,
    arg_fechaContrato fragmentoEmpleado.fechaContrato%TYPE,
    arg_salario    fragmentoEmpleado.salario%TYPE,
    arg_idHotel    fragmentoHotel.idHotel%TYPE) AS

    provinciaHotel fragmentoHotel.provincia%TYPE;
BEGIN
    SELECT provincia
    INTO provinciaHotel
    FROM Hotel
    WHERE idHotel=arg_idHotel;

    IF ( provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos1.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen' ) THEN
        INSERT INTO magnos2.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos2.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria' ) THEN
        INSERT INTO magnos3.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos3.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba' ) THEN
        INSERT INTO magnos4.fragmentoEmpleado(idEmpleado,dni,nombre,telefono,direccion,fechaContrato,salario)
        VALUES (arg_idEmpleado,arg_dni,arg_nombre,arg_telefono,arg_direccion,arg_fechaContrato,arg_salario);
        INSERT INTO magnos4.fragmentoTrabaja(idEmpleado, idHotel)
        VALUES (arg_idEmpleado, arg_idHotel);
    ELSE
        RAISE_APPLICATION_ERROR(-20401, 'Provincia de Hotel erronea');
    END IF;
    COMMIT;
END;
/

-- 2. Dar de baja a un empleado. --
CREATE OR REPLACE PROCEDURE bajaEmpleado (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE ) AS

    provinciaEmp hotel.provincia%TYPE;
BEGIN
    SELECT provincia INTO provinciaEmp FROM trabaja, hotel
    WHERE   trabaja.idEmpleado = arg_idEmpleado
            AND
            trabaja.idHotel = hotel.idHotel;

    IF ( provinciaEmp = 'Cadiz' OR provinciaEmp = 'Huelva' ) THEN
        DELETE FROM magnos1.fragmentoTrabaja WHERE idEmpleado = arg_idEmpleado;
        DELETE FROM magnos1.fragmentoEmpleado WHERE idEmpleado = arg_idEmpleado;
    ELSIF ( provinciaEmp = 'Granada' OR provinciaEmp = 'Jaen' ) THEN
        DELETE FROM magnos2.fragmentoTrabaja WHERE idEmpleado = arg_idEmpleado;
        DELETE FROM magnos2.fragmentoEmpleado WHERE idEmpleado = arg_idEmpleado;
    ELSIF ( provinciaEmp = 'Malaga' OR provinciaEmp = 'Almeria' ) THEN
        DELETE FROM magnos3.fragmentoTrabaja WHERE idEmpleado = arg_idEmpleado;
        DELETE FROM magnos3.fragmentoEmpleado WHERE idEmpleado = arg_idEmpleado;
    ELSIF ( provinciaEmp = 'Sevilla' OR provinciaEmp = 'Cordoba' ) THEN
        DELETE FROM magnos4.fragmentoTrabaja WHERE idEmpleado = arg_idEmpleado;
        DELETE FROM magnos4.fragmentoEmpleado WHERE idEmpleado = arg_idEmpleado;
    ELSE
        RAISE_APPLICATION_ERROR(-20401, 'Provincia vacia en bajaEmpleado');
    END IF;
    COMMIT;
END;
/

-- 3. Modificar el salario de un empleado. --
CREATE OR REPLACE PROCEDURE modificarSalario (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE,
    arg_salario fragmentoEmpleado.salario%TYPE) AS

    provinciaEmpleado fragmentoHotel.provincia%TYPE;
BEGIN
   SELECT provincia
   INTO provinciaEmpleado
   FROM trabaja, hotel
   WHERE trabaja.idEmpleado = arg_idEmpleado
      AND trabaja.idHotel = hotel.idHotel;

   IF ( provinciaEmpleado = 'Cadiz' OR provinciaEmpleado = 'Huelva' ) THEN
      UPDATE magnos1.fragmentoEmpleado
      SET salario = arg_salario
      WHERE idEmpleado = arg_idEmpleado;
   ELSIF ( provinciaEmpleado = 'Granada' OR provinciaEmpleado = 'Jaen' ) THEN
      UPDATE magnos2.fragmentoEmpleado
      SET salario = arg_salario
      WHERE idEmpleado = arg_idEmpleado;
   ELSIF ( provinciaEmpleado = 'Malaga' OR provinciaEmpleado = 'Almeria' ) THEN
      UPDATE magnos3.fragmentoEmpleado
      SET salario = arg_salario
      WHERE idEmpleado = arg_idEmpleado;
   ELSIF ( provinciaEmpleado = 'Sevilla' OR provinciaEmpleado = 'Cordoba' ) THEN
      UPDATE magnos4.fragmentoEmpleado
      SET salario = arg_salario
      WHERE idEmpleado = arg_idEmpleado;
   ELSE
      RAISE_APPLICATION_ERROR(-20411, 'Resultado vacío de la consulta');
   END IF;
   COMMIT;
END;
/

-- 4. Trasladar de hotel a un empleado. --
-- Los atributos en los que no se especifica lo que se hace con ellos, hemos decidido copiarlos al nuevo destino
CREATE OR REPLACE PROCEDURE trasladarEmpleado (
    arg_idEmpleado fragmentoEmpleado.idEmpleado%TYPE,
    arg_idHotel fragmentoTrabaja.idHotel%TYPE,
    arg_direccion fragmentoEmpleado.direccion%TYPE DEFAULT NULL,
    arg_telefono fragmentoEmpleado.telefono%TYPE DEFAULT NULL)AS

    dniEmpleado fragmentoEmpleado.dni%TYPE;
    nombreEmpleado  fragmentoEmpleado.nombre%TYPE;
    fechaContratoEmpleado   fragmentoEmpleado.fechaContrato%TYPE;
    salarioEmpleado  fragmentoEmpleado.salario%TYPE;

BEGIN

    SELECT dni, nombre, fechaContrato, salario
    INTO dniEmpleado, nombreEmpleado, fechaContratoEmpleado, salarioEmpleado
    FROM empleado
    WHERE idEmpleado = arg_idEmpleado;

    bajaEmpleado(arg_idEmpleado);
    altaEmpleado(arg_idEmpleado,
                 dniEmpleado,
                 nombreEmpleado,
                 arg_direccion,
                 arg_telefono,
                 fechaContratoEmpleado,
                 salarioEmpleado,
                 arg_idHotel
                 );
    COMMIT;
END;
/

-- 5. Dar de alta un nuevo hotel --
CREATE OR REPLACE PROCEDURE altaHotel (
    arg_idHotel    fragmentoHotel.idHotel%TYPE,
    arg_nombre  fragmentoHotel.nombre%TYPE,
    arg_provincia fragmentoHotel.provincia%TYPE,
    arg_ciudad  fragmentoHotel.ciudad%TYPE,
    arg_sencillasLibres fragmentoHotel.sencillasLibres%TYPE,
    arg_doblesLibres  fragmentoHotel.doblesLibres%TYPE ) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Alta hotel en: ' || arg_provincia || ' marchando');
    IF ( arg_provincia = 'Cadiz' OR arg_provincia = 'Huelva' ) THEN
        INSERT INTO magnos1.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Granada' OR arg_provincia = 'Jaen' ) THEN
        INSERT INTO magnos2.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Malaga' OR arg_provincia = 'Almeria' ) THEN
        INSERT INTO magnos3.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSIF ( arg_provincia = 'Sevilla' OR arg_provincia = 'Cordoba' ) THEN
        INSERT INTO magnos4.fragmentoHotel(idHotel,nombre,provincia,ciudad,sencillasLibres,doblesLibres)
        VALUES (arg_idHotel,arg_nombre,arg_provincia,arg_ciudad,arg_sencillasLibres,arg_doblesLibres);
    ELSE
        RAISE_APPLICATION_ERROR(-20402, 'Provincia erronea');
    END IF;
    COMMIT;
END;
/

-- 6. Cambiar el director de un hotel.
CREATE OR REPLACE PROCEDURE cambiarDirector (
    arg_idHotel     hotel.idHotel%TYPE,
    arg_idDirector  hotel.idDirector%TYPE ) AS

    numDirectores   NUMBER;
    numHoteles      NUMBER;
    provinciaHotel  fragmentoHotel.provincia%TYPE;
BEGIN
    -- Si el director ya dirige un hotel, error.
    SELECT COUNT(*) INTO numDirectores
    FROM Hotel
    WHERE idDirector = arg_idDirector;

    IF numDirectores > 0 THEN
        RAISE_APPLICATION_ERROR(-20403, 'Este empleado ya dirige un hotel');
    END IF;

    -- Si el hotel no existe, error. Si existe, modificamos la tupla
    -- insertando (o cambiando si ya tenia uno) su director
    SELECT COUNT(*) INTO numHoteles
    FROM Hotel
    WHERE idHotel = arg_idHotel;

    IF numHoteles = 0 THEN
        RAISE_APPLICATION_ERROR(-20404, 'Este hotel no existe en la base de datos');
    ELSE
      SELECT provincia
      INTO provinciaHotel
      FROM hotel
      WHERE hotel.idHotel = arg_idHotel;

      IF ( provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva' ) THEN
         UPDATE magnos1.fragmentoHotel
         SET idDirector = arg_idDirector
         WHERE idHotel = arg_idHotel;
      ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen' ) THEN
         UPDATE magnos2.fragmentoHotel
         SET idDirector = arg_idDirector
         WHERE idHotel = arg_idHotel;
      ELSIF ( provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria' ) THEN
         UPDATE magnos3.fragmentoHotel
         SET idDirector = arg_idDirector
         WHERE idHotel = arg_idHotel;
      ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba' ) THEN
         UPDATE magnos4.fragmentoHotel
         SET idDirector = arg_idDirector
         WHERE idHotel = arg_idHotel;
      END IF;
    END IF;
    COMMIT;
END;
/

-- 7. Dar de alta a un nuevo cliente --
CREATE OR REPLACE PROCEDURE nuevoCliente (
    arg_idCliente    cliente.idCliente%TYPE,
    arg_DNI     cliente.DNI%TYPE,
    arg_nombre  cliente.nombre%TYPE,
    arg_telefono    cliente.telefono%TYPE ) AS

    clientes NUMBER;
BEGIN
    SELECT COUNT(*) INTO clientes FROM cliente WHERE idCliente=arg_idCliente OR DNI=arg_DNI;

    IF clientes = 0 THEN
        INSERT INTO magnos1.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos2.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos3.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
        INSERT INTO magnos4.cliente VALUES (arg_idCliente,arg_DNI,arg_nombre,arg_telefono);
    ELSE
        RAISE_APPLICATION_ERROR(-20405,'Este cliente ya existe');
    END IF;
    COMMIT;
END;
/

-- 8. Dar de alta o actualizar una reserva
CREATE OR REPLACE PROCEDURE actualizarReserva (
    arg_idCliente       cliente.idCliente%TYPE,
    arg_idHotel         hotel.idHotel%TYPE,
    arg_tipoHab         reserva.tipoHabitacion%TYPE,
    arg_precio          reserva.precioNoche%TYPE,
    arg_fechaEntrada    reserva.fechaEntrada%TYPE,
    arg_fechaSalida     reserva.fechaSalida%TYPE ) AS

    numReservas NUMBER;
    provinciaHotel hotel.provincia%TYPE;
BEGIN

    SELECT COUNT(*) INTO numReservas
    FROM Reserva
    WHERE   idCliente = arg_idCliente
            AND
            fechaEntrada = arg_fechaEntrada
            AND
            fechaSalida = arg_fechaSalida;


    SELECT provincia INTO provinciaHotel
    FROM Hotel
    WHERE idHotel = arg_idHotel;

    -- Si hay una reserva con los datos suministrados, la eliminamos.
    -- En cualquier caso, despues no existe y se inserta como si fuera nueva.
    IF numReservas > 0 THEN
        anularReserva(arg_idCliente, arg_idHotel, arg_fechaEntrada, arg_fechaSalida);
    END IF;

    IF (provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva') THEN
        INSERT INTO magnos1.fragmentoReserva
        (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
        VALUES
        (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
    ELSIF (provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen') THEN
        INSERT INTO magnos2.fragmentoReserva
        (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
        VALUES
        (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
    ELSIF (provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria') THEN
        INSERT INTO magnos3.fragmentoReserva
        (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
        VALUES
        (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
    ELSIF (provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba') THEN
        INSERT INTO magnos4.fragmentoReserva
        (idCliente, idHotel, tipoHabitacion, precioNoche, fechaEntrada, fechaSalida)
        VALUES
        (arg_idCliente, arg_idHotel, arg_tipoHab, arg_precio, arg_fechaEntrada, arg_fechaSalida);
    END IF;
    COMMIT;
END;
/

-- 9. Anular reserva (creo que esta bien, revisar porfa) --
CREATE OR REPLACE PROCEDURE anularReserva (
    arg_idCliente fragmentoReserva.idCliente%TYPE,
    arg_idHotel fragmentoReserva.idHotel%TYPE,
    arg_fechaEntrada fragmentoReserva.fechaEntrada%TYPE,
    arg_fechaSalida    fragmentoReserva.fechaSalida%TYPE ) AS

    provinciaHotel fragmentoHotel.provincia%TYPE;
BEGIN
    SELECT provincia INTO provinciaHotel FROM Hotel WHERE idHotel=arg_idHotel;

    IF ( provinciaHotel = 'Cadiz' OR provinciaHotel = 'Huelva' ) THEN
        DELETE FROM magnos1.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Granada' OR provinciaHotel = 'Jaen' ) THEN
        DELETE FROM magnos2.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Malaga' OR provinciaHotel = 'Almeria' ) THEN
        DELETE FROM magnos3.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSIF ( provinciaHotel = 'Sevilla' OR provinciaHotel = 'Cordoba' ) THEN
        DELETE FROM magnos4.fragmentoReserva
        WHERE idCliente=arg_idCliente AND idHotel=arg_idHotel AND fechaEntrada=arg_fechaEntrada AND fechaSalida=arg_fechaSalida;
    ELSE
        RAISE_APPLICATION_ERROR(-20406, 'Provincia de Hotel erronea');
    END IF;
    COMMIT;
END;
/

-- 10. Dar de alta a un nuevo proveedor. --
CREATE OR REPLACE PROCEDURE altaProveedor(
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE,
    arg_nombre  magnos2.fragmentoProveedor.nombre%TYPE,
    arg_provincia magnos2.fragmentoProveedor.provincia%TYPE) AS
BEGIN
    CASE arg_provincia
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoProveedor(idProveedor,nombre,provincia)
            VALUES (arg_idProveedor,arg_nombre,arg_provincia) ;
        ELSE
            RAISE_APPLICATION_ERROR(-20407, 'Provincia erronea');
    END CASE;
    COMMIT;
END;
/

-- 11. Dar de baja a un proveedor. --
CREATE OR REPLACE PROCEDURE bajaProveedor(
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE) AS
    existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO existe FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    IF existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20410, 'No se ha podido dar de baja el proveedor porque no existe');
    ELSE
        DELETE FROM magnos2.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
        DELETE FROM magnos4.fragmentoProveedor WHERE idProveedor = arg_idProveedor;
    END IF;
    COMMIT;
END;
/

-- 12. Dar de alta o actualizar un suministro --
CREATE OR REPLACE PROCEDURE altaActualizaSuministro(
    arg_idArticulo          magnos2.fragmentoSuministro.idArticulo%TYPE,
    arg_idProveedor         magnos2.fragmentoSuministro.idProveedor%TYPE,
    arg_idHotel            	magnos2.fragmentoSuministro.idHotel%TYPE,
    arg_fecha               magnos2.fragmentoSuministro.fecha%TYPE,
    arg_cantidad        	magnos2.fragmentoSuministro.cantidad%TYPE,
    arg_precioUnidad 		magnos2.fragmentoSuministro.precioUnidad%TYPE) AS

    yaExiste            number;
    provinciaProveedor  magnos2.fragmentoProveedor.provincia%TYPE;
BEGIN
    -- lo borramos si esta
    DELETE FROM magnos2.fragmentoSuministro WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor
        AND idArticulo = arg_idArticulo AND fecha = arg_fecha;
    DELETE FROM magnos4.fragmentoSuministro WHERE idHotel = arg_idHotel AND idProveedor = arg_idProveedor
        AND idArticulo = arg_idArticulo AND fecha = arg_fecha;

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada'THEN
            INSERT INTO magnos2.fragmentoSuministro(idArticulo,idProveedor,idHotel,fecha,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fecha,arg_cantidad,arg_precioUnidad);
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoSuministro(idArticulo,idProveedor,idHotel,fecha,cantidad,precioUnidad)
            VALUES (arg_idArticulo,arg_idProveedor,arg_idHotel,arg_fecha,arg_cantidad,arg_precioUnidad);
        ELSE
            RAISE_APPLICATION_ERROR(-20408, 'Provincia erronea');
    END CASE;
    COMMIT;
END;
/

-- 13. Dar de baja un suministro.
CREATE OR REPLACE PROCEDURE bajaSuministros (
    arg_idHotel     suministro.idHotel%TYPE,
    arg_idProveedor suministro.idProveedor%TYPE,
    arg_idArticulo  suministro.idArticulo%TYPE,
    arg_fecha       suministro.fecha%TYPE DEFAULT NULL ) AS

    provinciaProveedor proveedor.provincia%TYPE;
    existe NUMBER;
BEGIN
    SELECT provincia INTO provinciaProveedor FROM proveedor
    WHERE proveedor.idProveedor = arg_idProveedor;

    SELECT COUNT(*) INTO existe FROM suministro
    WHERE   idHotel = arg_idHotel
            AND
            idArticulo = arg_idArticulo
            AND
            idProveedor = arg_idProveedor;

    IF existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20412, 'No se puede dar de baja el suministro porque no existe');
    ELSE
        -- Si no hay fecha, eliminamos todas las que tengan los otros dos parametros
        IF arg_fecha IS NULL THEN
            CASE provinciaProveedor
                WHEN 'Granada'THEN
                    DELETE FROM magnos2.fragmentoSuministro
                    WHERE   idHotel = arg_idHotel
                            AND
                            idArticulo = arg_idArticulo
                            AND
                            idProveedor = arg_idProveedor;
                WHEN 'Sevilla' THEN
                    DELETE FROM magnos4.fragmentoSuministro
                    WHERE   idHotel = arg_idHotel
                            AND
                            idArticulo = arg_idArticulo
                            AND
                            idProveedor = arg_idProveedor;
                ELSE
                    RAISE_APPLICATION_ERROR(-20407, 'Provincia erronea');
            END CASE;
        -- Si hay fecha, eliminamos esa en concreto
        ELSE
            CASE provinciaProveedor
                WHEN 'Granada'THEN
                    DELETE FROM magnos2.fragmentoSuministro
                    WHERE   idHotel = arg_idHotel
                            AND
                            idArticulo = arg_idArticulo
                            AND
                            idProveedor = arg_idProveedor
                            AND
                            fecha = arg_fecha;
                WHEN 'Sevilla' THEN
                    DELETE FROM magnos4.fragmentoSuministro
                    WHERE   idHotel = arg_idHotel
                            AND
                            idArticulo = arg_idArticulo
                            AND
                            idProveedor = arg_idProveedor
                            AND
                            fecha = arg_fecha;
                ELSE
                    RAISE_APPLICATION_ERROR(-20407, 'Provincia erronea');
            END CASE;
        END IF;
    END IF;
    COMMIT;
END;
/

-- 14. Dar de alta un nuevo articulo. --
CREATE OR REPLACE PROCEDURE altaArticulo(
    arg_idArticulo    magnos2.articulo.idArticulo%TYPE,
    arg_nombre  magnos2.articulo.nombre%TYPE,
    arg_tipo    magnos2.articulo.tipo%TYPE,
    arg_idProveedor    magnos2.fragmentoProveedor.idProveedor%TYPE) AS

    provinciaProveedor magnos2.fragmentoProveedor.provincia%TYPE;
    numArticulos NUMBER;
BEGIN
    SELECT COUNT(*) INTO numArticulos FROM magnos2.articulo
    WHERE idArticulo = arg_idArticulo;

    IF numArticulos = 0 THEN
        INSERT INTO magnos2.articulo(idArticulo,nombre,tipo)
            VALUES (arg_idArticulo,arg_nombre,arg_tipo);
        INSERT INTO magnos4.articulo(idArticulo,nombre,tipo)
            VALUES (arg_idArticulo,arg_nombre,arg_tipo);
    END IF;

    SELECT provincia
    INTO provinciaProveedor
    FROM proveedor
    WHERE idProveedor = arg_idProveedor;

    CASE provinciaProveedor
        WHEN 'Granada' THEN
            INSERT INTO magnos2.fragmentoTiene(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        WHEN 'Sevilla' THEN
            INSERT INTO magnos4.fragmentoTiene(idProveedor,idArticulo)
            VALUES (arg_idProveedor,arg_idArticulo) ;
        ELSE
            RAISE_APPLICATION_ERROR(-20409, 'Provincia erronea');
    END CASE;
    COMMIT;
END;
/

-- 15. Dar de baja un articulo. --
CREATE OR REPLACE PROCEDURE bajaArticulo (
    arg_idArticulo  articulo.idArticulo%TYPE ) AS

    numSuministros NUMBER;
    existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO numSuministros
    FROM suministro
    WHERE idArticulo=arg_idArticulo AND cantidad>0;

    IF numSuministros > 0 THEN
        RAISE_APPLICATION_ERROR(-20450,'El artículo tiene suministros');
    END IF;

    SELECT COUNT(*) INTO existe FROM suministro
    WHERE suministro.idArticulo = arg_idArticulo;

    IF existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20415, 'No es posible dar de baja el artículo pues no existe en la base de datos');
    ELSE
        DELETE FROM magnos2.fragmentoSuministro WHERE idArticulo=arg_idArticulo;
        DELETE FROM magnos4.fragmentoSuministro WHERE idArticulo=arg_idArticulo;

        DELETE FROM magnos2.articulo WHERE idArticulo=arg_idArticulo;
        DELETE FROM magnos4.articulo WHERE idArticulo=arg_idArticulo;
    END IF;
    COMMIT;
END;
/

COMMIT;
```
#Datos de Prueba
```SQL
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
```
##Consultas
```SQL
-- Consulta 1
SELECT H.nombre,H.ciudad,P.nombre,P.provincia
FROM hotel H, proveedor P, suministro S, articulo A
WHERE
	(H.ciudad = 'Granada' OR H.ciudad = 'Huelva' OR H.ciudad = 'Almeria')
	AND S.idHotel = H.idHotel AND S.idProveedor = P.idProveedor AND S.idArticulo = A.idArticulo
	AND (A.nombre = 'Queso' OR A.nombre = 'Mantequilla' )
	AND S.fecha between to_date('12/05/2014','DD/MM/YYYY')
	AND to_date('28/05/2014','DD/MM/YYYY');


-- Consulta 2
SELECT A.nombre, H.nombre, H.ciudad, SUM(Cantidad)
FROM articulo A, hotel H, suministro S
WHERE S.idHotel = H.idHotel AND S.idArticulo = A.idArticulo AND S.idProveedor = &pIdentificador
GROUP BY A.nombre, H.nombre, H.ciudad
HAVING H.ciudad = 'Jaen' OR H.ciudad = 'Almeria';


-- Consulta 3
SELECT C.nombre, C.telefono
FROM cliente C, reserva R
WHERE C.idCliente = R.idCliente
GROUP BY C.nombre, C.telefono
HAVING COUNT(*)>1;
```
