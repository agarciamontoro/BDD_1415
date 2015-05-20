 --PERMISOS MAGNOS1--
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoEmpleado TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoHotel TO Magnos2,Magnos3,Magnos4;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoProveedor TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoReserva TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoTiene TO Magnos2,Magnos3,Magnos4 ;
GRANT SELECT,UPDATE,DELETE,INSERT ON fragmentoSuministro TO Magnos2,Magnos3,Magnos4 ;
/*
--PERMISOS MAGNOS2--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos3,Magnos4 ON fragmentoSuministro;

--PERMISOS MAGNOS3--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos4 ON fragmentoSuministro;

--PERMISOS MAGNOS4--
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoEmpleado;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoHotel;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoProveedor;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoReserva;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoTiene;
GRANT SELECT,UPDATE,DELETE,INSERT TO Magnos1,Magnos2,Magnos3 ON fragmentoSuministro;
