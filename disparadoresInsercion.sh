#!/bin/bash

TABLAS=( cliente empleado hotel trabaja reserva proveedor articulo tiene suministro)
LLAVES=( "idCliente = :NEW.idCliente"
		 "idEmpleado = :NEW.idCliente"
		 "idHotel = :NEW.idHotel"
		 "idEmpleado = :NEW.idEmpleado"
		 "idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida"
		 "idProveedor = :NEW.idProveedor"
		 "idArticulo = :NEW.idArticulo"
		 "idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo"
		 "idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo"
		)

rm disparadoresInsercion.sql

for i in `seq 0 8`
do
	echo "" >> disparadoresInsercion.sql
	echo "-------------------------------------------------------" >> disparadoresInsercion.sql
	echo "" >> disparadoresInsercion.sql
	echo "CREATE OR REPLACE TRIGGER restriccionLlaveUnica" >> disparadoresInsercion.sql
	echo "BEFORE INSERT OR UPDATE ON ${TABLAS[$i]}" >> disparadoresInsercion.sql
	echo "FOR EACH ROW" >> disparadoresInsercion.sql
	echo "DECLARE" >> disparadoresInsercion.sql
	echo "  numTuplas NUMBER;" >> disparadoresInsercion.sql
	echo "BEGIN" >> disparadoresInsercion.sql
	echo "  SELECT COUNT(*) INTO numTuplas FROM ${TABLAS[$i]}" >> disparadoresInsercion.sql
	echo "  WHERE ${LLAVES[$i]};" >> disparadoresInsercion.sql >> disparadoresInsercion.sql
	echo "	IF numTuplas > 0 THEN" >> disparadoresInsercion.sql
	echo "  	RAISE_APPLICATION_ERROR(-20001,'Restricción de llave única violada: la llave ya existe en la tabla')" >> disparadoresInsercion.sql
	echo "  END IF;" >> disparadoresInsercion.sql
	echo "END;" >> disparadoresInsercion.sql
done