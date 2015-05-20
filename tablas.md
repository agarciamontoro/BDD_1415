Estas son las tablas:

Cliente(_idCliente_, DNI, nombre, telefono)

Empleado(_idEmpleado_, salario, DNI, nombre, telefono, direccion, fechaContrato)

Hotel(_idHotel_, nombre, ciudad, sencillasLibres, doblesLibes)

Proveedor(_idProveedor_, nombre, ciudad)

Articulo(_idArticulo_, nombre, tipo)

Reserva(_idCliente, fechaEntrada, fechaSalida_, idHotel, precioNoche, tipoHabitacion, )

Dirige(_idEmpleado_, idHotel)

Trabaja(_idEmpleado_, idHotel)

Tiene(_idProveedor, idArticulo_)

Suministro(_idHotel, fecha, idProveedor, idArticulo_, cantidad, precioUnidad)

Ahora vamos a propagar las siguientes llaves de las tablas:

**Dirige y Hotel**
Hotel=DirigeHotel(_idHotel_, nombre, ciudad, sencillasLibres, doblesLibes, idDirector)
