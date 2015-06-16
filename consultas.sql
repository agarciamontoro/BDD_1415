-- Ejemplo de consulta paramétrica
SELECT numEmp, nombreEmp, salario, numDept
FROM Empleados
WHERE numEmp = &Num_Emp;
-- Fin ejemplo


-- Ej 1
SELECT H.nombre,H.ciudad,P.nombre,P.ciudad
FROM hotel H, proveedor P, suministro S, articulo A
WHERE
	(H.ciudad = 'Granada' OR H.ciudad = 'Huelva' OR H.ciudad = 'Almeria')
	AND S.idHotel = H.idHotel AND S.idProveedor = P.idProveedor AND S.idArticulo = A.idArticulo
	AND (A.nombre = 'Queso' OR A.nombre = 'Mantequilla' )
	AND S.fecha between to_date('12/05/2014','DD/MM/YYYY')
	AND to_date('28/05/2014','DD/MM/YYYY');



-- Ej 2
SELECT A.nombre, H.nombre, H.ciudad, SUM(Cantidad)
FROM articulo A, hotel H, suministro S
WHERE S.idHotel = H.idHotel AND S.idArticulo = A.idArticulo AND S.idProveedor = &pIdentificador
GROUP BY A.nombre, H.nombre, H.ciudad
HAVING H.ciudad = 'Jaen' OR H.ciudad = 'Almeria';


-- Ej 3
SELECT C.nombre, C.telefono
FROM cliente C, reserva R
WHERE C.idCliente = R.idCliente
GROUP BY C.nombre, C.telefono
HAVING COUNT(*)>1;
