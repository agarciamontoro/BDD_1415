#Diseño de la fragmentación y de la asignación
##Introducción
La base de datos distribuida, tendrá sus datos físicos almacenados en cuatro localidades **Granada, Cádiz, Sevilla, Málaga**.

Y cada una de estas localidades almacenará la información de los siguientes lugares:

1. **Granada** = Granada y Jaén
2. **Cádiz** = Cádiz y Huelva
3. **Sevilla** = Sevilla y Córdoba
4. **Málaga** = Málaga y Almería

Ahora basándonos en el diagrama *Entidad Relación realizado anteriormente* y éstos datos, nos proponemos a hacer la fragmentación.

##Fragmentación
###Tablas a fragmentar.
Para este problema, es claro que hay que hacer una fragmentación horizontal con el atributo ciudad, ya que los datos se dividen en diferentes ciudades según la zona, y de esta manera, conseguiremos que los accesos en cada una de las zonas sean más probables locales ya que lo más normal es que la mayoría de las consultas en un hotel serán en los datos de su propia ciudad.

Cómo podemos observar las tablas que tienen los atributos de ciudad son: **Hotel y Proveedor**

####Hotel

Predicados simples:

    P = { Ciudad = Granada, Ciudad = Jaén, Ciudad = Cádiz, Ciudad = Huelva, Ciudad = Sevilla, Ciudad = Córdoba, Ciudad = Málaga, Ciudad = Almería } }

Para facilitarnos la tarea, notemos cada predicado.

1. Pgra = Ciudad = Granada
2. Pjae = Ciudad = Jaén
3. Pcad = Ciudad = Cádiz
4. Phue = Ciudad = Huelva
5. Psev = Ciudad = Sevilla
6. Pcor = Ciudad = Córdoba
7. Pmal = Ciudad = Málaga
8. Palm = Ciudad = Añmería

Los predicados verdaderos:

1. y1 =   Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm
2. y2 =  ¬Pgra ^ Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm 
3. y3 =  ¬Pgra ^ ¬Pjae ^ Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm 
4. y4 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm 
5. y5 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ Psev ^ ¬Pcor ^ ¬Pmal ^ ¬Palm 
6. y6 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ Pcor ^ ¬Pmal ^ ¬Palm 
7. y7 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ Pmal ^ ¬Palm 
8. y8 =  ¬Pgra ^ ¬Pjae ^ ¬Pcad ^ ¬Phue ^ ¬Psev ^ ¬Pcor ^ ¬Pmal ^ Palm 

Entonces nos da cómo resultado 8 fragmentos:

1. Hotel1 = SL1(Hotel)
2. Hotel2 = SL2(Hotel)
3. Hotel3 = SL3(Hotel)
4. Hotel4 = SL4(Hotel)
5. Hotel5 = SL5(Hotel)
6. Hotel6 = SL6(Hotel)
7. Hotel7 = SL7(Hotel)
8. Hotel8 = SL8(Hotel)

Entonces hacemos la asignación de tal forma que se adapte a la representación física que se proporciona

1. Granada: Hotel1,Hotel2
2. Cádiz: Hotel3,Hotel4
3. Sevilla: Hotel5,Hotel6
4. Málaga: Hotel7,Hotel8

####Proveedor





Ahora, tenemos también tablas que no usen directamente el atributo ciudad, pero indirectamente si puede que lo necesiten o lo usen.
Para estas tablas entonces usaremos una fragmentación horizontal derivada

#####Empleado
La hacemos a partir del Hotel.

Resultan 8 fragmentos:

1. Empleado1 = Empleado SJNCodH=CodH Hotel1
2. Empleado2 = Empleado SJNCodH=CodH Hotel2
3. Empleado3 = Empleado SJNCodH=CodH Hotel3
4. Empleado4 = Empleado SJNCodH=CodH Hotel4
5. Empleado5 = Empleado SJNCodH=CodH Hotel5
6. Empleado6 = Empleado SJNCodH=CodH Hotel6
7. Empleado7 = Empleado SJNCodH=CodH Hotel7
8. Empleado8 = Empleado SJNCodH=CodH Hotel8

La asignación la hacemos de la siguiente forma:

1. Granada: Empleado1, Empleado2
2. Cádiz: Empleado3, Empleado4
3. Sevilla: Empleado5, Empleado6
4. Málaga: Empleado7, Empleado8

#####Reserva
La hacemos a partir del Hotel.

Resultan 8 fragmentos:

1. Reserva1 = Reserva SJNCodH=CodH Hotel1
2. Reserva2 = Reserva SJNCodH=CodH Hotel2
3. Reserva3 = Reserva SJNCodH=CodH Hotel3
4. Reserva4 = Reserva SJNCodH=CodH Hotel4
5. Reserva5 = Reserva SJNCodH=CodH Hotel5
6. Reserva6 = Reserva SJNCodH=CodH Hotel6
7. Reserva7 = Reserva SJNCodH=CodH Hotel7
8. Reserva8 = Reserva SJNCodH=CodH Hotel8

La asignación la hacemos de la siguiente forma:

1. Granada: Reserva1, Reserva2
2. Cádiz: Reserva3, Reserva4
3. Sevilla: Reserva5, Reserva6
4. Málaga: Reserva7, Reserva8


#####Siministro
Lo hacemos a partir del Hotel

Resultan 8 fragmentos:

1. Siministro1 = Siministro SJNCodH=CodH Hotel1
2. Siministro2 = Siministro SJNCodH=CodH Hotel2
3. Siministro3 = Siministro SJNCodH=CodH Hotel3
4. Siministro4 = Siministro SJNCodH=CodH Hotel4
5. Siministro5 = Siministro SJNCodH=CodH Hotel5
6. Siministro6 = Siministro SJNCodH=CodH Hotel6
7. Siministro7 = Siministro SJNCodH=CodH Hotel7
8. Siministro8 = Siministro SJNCodH=CodH Hotel8

La asignación la hacemos de la siguiente forma:

1. Granada: Siministro1, Siministro2
2. Cádiz: Siministro, Siministro4
3. Sevilla: Siministro5, Siministro6
4. Málaga: Siministro7, Siministro8

#####Tiene
La hacemos a partir del Proveedor.

Resultan 

#####Cliente
La replicamos en todos los puntos de almacenamiento. Lo hacemos así ya que un cliente no está intrínsicamente relacionado con ninguna zona geográfica a partir de la que hemos hecho las fragmentaciones. 

#####Artículo
La replicamos en los puntos de almacenamiento de los proveedores. Lo hacemos así ya que un artículo no está intrínsicamente relacionado con ninguna zona geográfica, pero sólo serán usados por los proveedores.




