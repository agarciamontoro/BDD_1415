CREATE OR REPLACE TRIGGER replicacionCliente
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
  INSERT INTO magnos1.cliente
  (
    idCliente,
    DNI,
    nombre,
    telefono
  )
  VALUES
  (
    :NEW.idCliente,
    :NEW.DNI,
    :NEW.nombre,
    :NEW.telefono 
  );
  
  INSERT INTO magnos2.cliente
  (
    idCliente,
    DNI,
    nombre,
    telefono 
  )
  VALUES
  (
    :NEW.idCliente,
    :NEW.DNI,
    :NEW.nombre,
    :NEW.telefono 
  );
  
  INSERT INTO magnos4.cliente
  (
    idCliente,
    DNI,
    nombre,
    telefono 
  )
  VALUES
  (
    :NEW.idCliente,
    :NEW.DNI,
    :NEW.nombre,
    :NEW.telefono 
  );
  
END;
/
/* Descomentar para Magnos2 - Granada, Magnos4 - Sevilla 
CREATE OR REPLACE TRIGGER replicacionArticulo
AFTER INSERT ON articulo
FOR EACH ROW
BEGIN

  INSERT INTO magnos2.articulo
  (
    idArticulo,
    nombre,
    tipo
  )
  VALUES
  (
    :NEW.idArticulo,
    :NEW.nombre,
    :NEW.tipo
  );

END;
/
*/