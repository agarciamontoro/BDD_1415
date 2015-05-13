#Diseño de la fragmentación y de la asignación
##Introducción
La base de datos distribuida tendrá sus datos físicos almacenados en cuatro localidades: **Granada, Cádiz, Sevilla, Málaga**.

Cada una de estas localidades almacenará la información de los siguientes lugares:

1. **Granada** = Granada y Jaén
2. **Cádiz** = Cádiz y Huelva
3. **Sevilla** = Sevilla y Córdoba
4. **Málaga** = Málaga y Almería

Ahora, basándonos en el diagrama *Entidad Relación realizado anteriormente* y estos datos, hacemos la fragmentación.

##Fragmentación
###Tablas a fragmentar.
La fragmentación la realizaremos en dos pasos:

1. Fragmentaciones horizontales primarias de aquellas tablas cuyas tuplas tengan una relación directa con la localidad en la que se encuentran.
2. Fragmentaciones horizontales, derivadas de las anteriores, de aquellas tablas que tengan una relación directa con los fragmentos. Tendremos en consideración el *grado de relación* de las tuplas con la localidad, de manera que en cada caso decidiremos entre fragmentación o replicación.

####Fragmentaciones horizontales primarias
Las dos únicas tablas cuyas tuplas tienen una relación directa -mediante un atributo de las mismas- de la localidad en la que se encuentran son **Hotel** y **Proveedor**.

Es claro entonces que la fragmentación hay que realizarla en base al atributo *ciudad* de las mismas. Esta decisión tiene como principal objetivo maximizar los accesos locales: los accesos que involucren a las tablas Hotel y Proveedor se realizarán, en su mayoría, desde las ciudades cuyas tuplas se necesita consultar.

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

#####Trabaja
La hacemos a partir del Hotel.

Resultan 8 fragmentos:

1. Trabaja1 = Trabaja SJNCodH=CodH Hotel1
2. Trabaja2 = Trabaja SJNCodH=CodH Hotel2
3. Trabaja3 = Trabaja SJNCodH=CodH Hotel3
4. Trabaja4 = Trabaja SJNCodH=CodH Hotel4
5. Trabaja5 = Trabaja SJNCodH=CodH Hotel5
6. Trabaja6 = Trabaja SJNCodH=CodH Hotel6
7. Trabaja7 = Trabaja SJNCodH=CodH Hotel7
8. Trabaja8 = Trabaja SJNCodH=CodH Hotel8

La asignación la hacemos de la siguiente forma:

1. Granada: Trabaja1, Trabaja2
2. Cádiz: Trabaja3, Trabaja4
3. Sevilla: Trabaja5, Trabaja6
4. Málaga: Trabaja7, Trabaja8

#####Dirige
La hacemos a partir de Hotel.

Resultan 8 fragmentos:

1. Dirige1 = Dirige SJNCodH=CodH Hotel1  
2. Dirige2 = Dirige SJNCodH=CodH Hotel2
3. Dirige3 = Dirige SJNCodH=CodH Hotel3
4. Dirige4 = Dirige SJNCodH=CodH Hotel4
5. Dirige5 = Dirige SJNCodH=CodH Hotel5
6. Dirige6 = Dirige SJNCodH=CodH Hotel6
7. Dirige7 = Dirige SJNCodH=CodH Hotel7
8. Dirige8 = Dirige SJNCodH=CodH Hotel8  

La asignación la hacemos de la siguiente forma:

1. Granada: Dirige1,Dirige2
2. Cádiz: Dirige3,Dirige4 
3. Sevilla: Dirige5,Dirige6 
4. Málaga: Dirige7,Dirige8 



