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
  
  INSERT INTO magnos3.cliente
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

CREATE OR REPLACE TRIGGER replicacionArticulo
AFTER INSERT ON articulo
FOR EACH ROW
BEGIN

  INSERT INTO magnos4.articulo
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