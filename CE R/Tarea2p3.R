##Tarea 2 Computaci?n Esradist?ca 2022-2
##Integrantes: Tania Vanesa Vasquez,  Angela Gissel L?pez Rodr?guez, Jhon Ramirez
##lunes 29/08/22

#peliculas

#Exportaciones agr?colas tradicionales en Colombia

#Cr?ditos
library(dplyr)
library(CASdatasets)
?CASdatasets
source("mismacros.txt")

help("dplyr")
library(dplyr)
install.packages("CASdatasets")
(data("credit"))
str(credit)

mytable(~class,data=credit,ord="freq")
#Qué porcentaje de la cartera (número de créditos) corresponde a créditos "malos"?
#30%

#Qué porcentaje de la cartera (valor de los créditos) corresponde a créditos "malos"?
mytable(credit_amount~ class,data=credit,ord="freq")  
#36.12% equivalente a 1181438                  

#El porcentaje de la cartera (número de créditos) que corresponde a créditos "malos" es menor para los clientes con "buen" historial crediticio?
mytable(~ credit_history,data=credit,subset=c(class == "1"),ord="-freq")
#No, extrañamente el 16.67 de los clientes con historia crediticia buena son catalogados como malos

#El porcentaje de la cartera (en valor) que corresponde a créditos "malos" es menor para los clientes con "buen" historial crediticio?
mytable(credit_amount ~ credit_history*class, data=credit,ord="freq")
#Contrario con la cantidad de creditos los clientes con buen historial crediticio ctalogados como malos, el porcentake es 6.26 siendo menor para los creditos malos

#El porcentaje de la cartera (número de créditos) que corresponde a créditos "malos" es menor para los clientes con empleos más estables?
mytable(~ job, data=credit,subset=c(class == "1"),ord="freq")
#NO de hecho es locontrario A173 se creeria que es un trabajo mas estable 
#pero el 62% de los cretidos malos correspone a esta categoiria, En el caso deñ A174 si se cumple
mytable(~ job*class, data=credit,ord="freq")

#El porcentaje de la cartera (valor de los créditos) que corresponde a créditos "malos" es menor para los clientes con empleos más estables?
mytable(credit_amount ~ job*class, data=credit,ord="freq")
mytable(credit_amount~ job, data=credit,subset=c(class == "1"),ord="freq")
#No el porsentaje es mayor para los clientes con empleos mas estables
