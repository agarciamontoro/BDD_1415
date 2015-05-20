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
  SELECT * FROM Magnos4.fragmentoSuministro;
  
CREATE VIEW trabaja AS
  SELECT * FROM Magnos1.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos2.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos3.fragmentoTrabaja
  UNION
  SELECT * FROM Magnos4.fragmentotrabaja;
