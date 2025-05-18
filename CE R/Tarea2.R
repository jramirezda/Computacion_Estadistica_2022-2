##Tarea 2 Computaci?n Esradist?ca 2022-2
##Integrantes: Tania Vanesa Vasquez,  Angela Gissel L?pez Rodr?guez, Jhon Ramirez
##lunes 29/08/22

#peliculas


#Exportaciones agr?colas tradicionales en Colombia
library(readxl)
library(dplyr)
source("mismacros.txt")

Exportaciones<-read_excel("exportaciones.xlsx")
str(Exportaciones)
?dplyr
#Qué porcentaje del volumen de las exportaciones de café en 2018 se hicieron durante el mes de agosto?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 9.25% del volumen de cafe fue exportado en algosto. 

#Qué porcentaje del volumen de las exportaciones de café en 2018 se hicieron durante el primer trimestre del año?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 26.60% del volumen de cafe fue exportado en el primer trimestre.
  
#Qué porcentaje del valor de las exportaciones de café en 2018 se hicieron durante el mes de septiembre?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 7,82% del volumen de cafe fue exportado en septiembre.

#Qué porcentaje del valor de las exportaciones de café en 2018 se hicieron durante el cuarto trimestre del año?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"), ord="-levels")
#De lo que concluimos que en 2018 el 26.27% del volumen de café exportado fue durante el ultimo trimestre del año. 

#Qué porcentaje del volumen de las exportaciones de flores en Antioquia en 2019 se hicieron durante el primer trimestre del año?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2019 & Producto=="Flores" & Departamento=="Antioquia"))
#De lo que concluimo que el 26,16% de las exportaciones de flores en Antioquia en 2019 se dieron en el primer trimestre del año.

#Qué porcentaje del volumen de las exportaciones de flores durante el primer trimestre del 2019 se hicieron desde Antioquia?
mytable(Volumen ~ Departamento , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Mes<=3))
#De lo que concluimos que el 27.32% de las exportaciones del primer trimestre de 2019 fueron desde Antioquuia.

#Qué porcentaje del valor de las exportaciones de flores en Antioquia en 2019 se hicieron durante el tercer trimestre del año?
mytable(Valor ~ Mes , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Departamento=="Antioquia"))
#De lo qu comcluimos que el 26.43% del valor de las exportaciones de Antioquia en 2019 se dieron en el primer trimestre.

#Qué porcentaje del valor de las exportaciones de flores durante el tercer trimestre del 2019 se hicieron desde Antioquia?
mytable(Valor ~ Departamento , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Mes %in% c(7,8,9)))
# de lo que concluimos que el 19.13% del valor de exportaciones de flores de antioquia en el 2019 son del tercer trimestre del año.
#Creditos
