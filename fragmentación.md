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

