#!/bin/bash

TABLAS=( fragmentoEmpleado fragmentoHotel fragmentoTrabaja fragmentoReserva fragmentoProveedor fragmentoTiene fragmentoSuministro)
VISTAS=( Empleado Hotel Trabaja Reserva Proveedor Tiene Suministro)
LLAVES=( "idEmpleado = :NEW.idEmpleado"
		 "idHotel = :NEW.idHotel"
		 "idEmpleado = :NEW.idEmpleado"
		 "idCliente = :NEW.idCliente AND fechaEntrada = :NEW.fechaEntrada AND fechaSalida = :NEW.fechaSalida"
		 "idProveedor = :NEW.idProveedor"
		 "idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo"
		 "idHotel = :NEW.idHotel AND fecha = :NEW.fecha AND idProveedor = :NEW.idProveedor AND idArticulo = :NEW.idArticulo"
		)

rm disparadoresInsercion.sql

for i in `seq 0 6`
do
	if [ ${VISTAS[$i]} == "Proveedor" ]; then
		echo "/* Solo para magnos2 - Granada y magnos4 - Sevilla" >> disparadoresInsercion.sql
	fi

	echo "" >> disparadoresInsercion.sql
	echo "-------------------------------------------------------" >> disparadoresInsercion.sql
	echo "" >> disparadoresInsercion.sql
	echo "CREATE OR REPLACE TRIGGER llaveUnica${VISTAS[$i]}" >> disparadoresInsercion.sql
	echo "BEFORE INSERT OR UPDATE ON ${TABLAS[$i]}" >> disparadoresInsercion.sql
	echo "FOR EACH ROW" >> disparadoresInsercion.sql
	echo "DECLARE" >> disparadoresInsercion.sql
	echo "PRAGMA AUTONOMOUS_TRANSACTION;" >> disparadoresInsercion.sql
	echo "  numTuplas NUMBER;" >> disparadoresInsercion.sql
	echo "BEGIN" >> disparadoresInsercion.sql
	echo "  SELECT COUNT(*) INTO numTuplas FROM ${VISTAS[$i]}" >> disparadoresInsercion.sql
	echo "  WHERE ${LLAVES[$i]};" >> disparadoresInsercion.sql >> disparadoresInsercion.sql
	echo "	IF numTuplas > 0 THEN" >> disparadoresInsercion.sql
	echo "  	RAISE_APPLICATION_ERROR(-2020$i,'Restricción de llave única violada: la llave ya existe en la tabla');" >> disparadoresInsercion.sql
	echo "  END IF;" >> disparadoresInsercion.sql
	echo "  COMMIT;" >> disparadoresInsercion.sql
	echo "END;" >> disparadoresInsercion.sql
	echo "/" >> disparadoresInsercion.sql

	if [ ${VISTAS[$i]} == "Suministro" ]; then
		echo "*/" >> disparadoresInsercion.sql
	fi
done