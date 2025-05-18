##Tarea 2 Computaci?n Esradist?ca 2022-2
##Integrantes: Tania Vanesa Vasquez,  Angela Gissel L?pez Rodr?guez, Jhon Ramirez
##lunes 29/08/22

#############Peliculas#################

library(readr)
library(stringr)

#Importe las variables Title, Year, Director y Country. Cuantas filas tiene el conjunto de datos resultante? Hay valores perdidos o missings? Cuantos? En qué variables?
#Hay 11,001 filas, si hay valores NA, en las variables year (4), Director(15) y Country(1367)

films <- read_delim("http://users.stat.ufl.edu/~winner/data/movie_avshotlength.csv",
                    delim=",", col_types=cols("c","i","c","c","-"), skip=1,
                    col_names=c("Title","Year","Director","Country"),
                    locale=locale(encoding="Latin1"))
str(films)
apply(films,2,function(x) sum(is.na(x)))



#Cuantas películas tienen solo 1 director(a)? Cuantas películas tienen 2 directores(as)? Cuantas películas tienen 3 o más directores(as)?
# 10751 peliculas con un solo director, 233 con dos directores y 2 con 3 o más
with(films,table(str_count(Director,"&") + 1))

#Cuantas y cuales películas tienen nombres que incluyen números?
# 351 peliculas, algunas de ellas son "11:14" "21" "300" "2012"
filmsnum <- subset(films,str_detect(Title,"[0-9]"))
str(filmsnum)
View(filmsnum)


#Cuantas y cuales películas tienen nombres que incluyen signos de puntuación?
# 4141 películas tienen nombres que incluyen signos de puntuación, algunas son "11:14" "*Batteries Not Included " "[Rec]3 Génesis "
filmspunt <- subset(films,str_detect(Title,"[:punct:]"))
str(filmspunt)


#Cree un conjunto de datos con las películas que tienen solo 1 director(a). Use la variable Director para crear una variable llamada Director2 teniendo en cuenta los siguientes parámetros: (a) Deben aparecer los nombre(s) y luego los apellido(s) del(de la) director(a) de la película separados por espacios sencillos y sin espacios al inicio ni al final; (b) Las iniciales de cada nombre y de cada apellido deben estar en letras mayúsculas.
films1dir <- subset(films,str_count(Director,"&")==0)
str(films1dir)

nombres <- with(films1dir,str_split_fixed(Director,",",n=2))

films1dir <- within(films1dir,{
  nombre <- str_to_title(str_squish(str_to_lower(nombres[,2])))
  apellido <- str_to_title(str_squish(str_to_lower(nombres[,1])))
  Director2 <- str_c(nombre,apellido,sep=" ")
  rm(nombre,apellido)
})
str(films1dir)
head(films1dir[,c("Director","Director2")],n=50)



#Cuantas y cuales películas fueron dirigidas por Kathryn Bigelow?
# 6 peliculas, "Hurt Locker, The " "K-19: The Widowmaker " "Near Dark " "Point Break " "Weight of Water, The " "Strange Days " 
KB=subset(films,str_detect(str_to_lower(Director),"bigelow.*kathryn"))
str(KB)
tail(KB)



#Cuantas y cuales películas fueron dirigidas por Martin Scorsese?
MS=subset(films,str_detect(str_to_lower(Director),"scorsese.*martin"))
str(MS)
# 19 peliculas, algunas de estas son "After Hours " "Age of Innocence, The " "Aviator, The " "Bringing Out the Dead "



#Cuantas y cuales películas son Argentinas?
ARG=subset(films,str_detect(Country,"ARG"))
str(ARG)
#16 peliculas, algunas de estas son "Antena, la " "Aura, El " "Bonaerense, el " "Ciénaga, la "


#Cuantas y cuales películas son Mexicanas?
MEX=subset(films,str_detect(Country,"MEX"))
str(MEX)
# 20 peliculas, algunas de estas son "Alamar " "Alucarda " "Amores Perros " "Angel externinador, el "

###########Exportaciones Agrícolas Tradicionales en Colombia#################### ####
library(readxl)
library(dplyr)
source("mismacros.txt")

Exportaciones<-read_excel("exportaciones.xlsx")
str(Exportaciones)
?dplyr
#Qué porcentaje del volumen de las exportaciones de café en 2018 se hicieron durante el mes de agosto?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 9.25% del volumen de cafe fue exportado en algosto. 

#Qué porcentaje del volumen de las exportaciones de café en 2018 se hicieron durante el primer trimestre del aÃ±o?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 26.60% del volumen de cafe fue exportado en el primer trimestre.

#Qué porcentaje del valor de las exportaciones de café en 2018 se hicieron durante el mes de septiembre?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"))
# de lo que concluimos que en 2018 el 7,82% del volumen de cafe fue exportado en septiembre.

#Qué porcentaje del valor de las exportaciones de café en 2018 se hicieron durante el cuarto trimestre del aÃ±o?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2018 & Producto=="Café"), ord="-levels")
#De lo que concluimos que en 2018 el 26.27% del volumen de café exportado fue durante el ultimo trimestre del aÃ±o. 

#Qué porcentaje del volumen de las exportaciones de flores en Antioquia en 2019 se hicieron durante el primer trimestre del aÃ±o?
mytable(Volumen ~ Mes , data = Exportaciones,subset = c(Ano==2019 & Producto=="Flores" & Departamento=="Antioquia"))
#De lo que concluimo que el 26,16% de las exportaciones de flores en Antioquia en 2019 se dieron en el primer trimestre del aÃ±o.

#Qué porcentaje del volumen de las exportaciones de flores durante el primer trimestre del 2019 se hicieron desde Antioquia?
mytable(Volumen ~ Departamento , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Mes<=3))
#De lo que concluimos que el 27.32% de las exportaciones del primer trimestre de 2019 fueron desde Antioquuia.

#Qué porcentaje del valor de las exportaciones de flores en Antioquia en 2019 se hicieron durante el tercer trimestre del aÃ±o?
mytable(Valor ~ Mes , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Departamento=="Antioquia"))
#De lo qu comcluimos que el 26.43% del valor de las exportaciones de Antioquia en 2019 se dieron en el primer trimestre.

#Qué porcentaje del valor de las exportaciones de flores durante el tercer trimestre del 2019 se hicieron desde Antioquia?
mytable(Valor ~ Departamento , data = Exportaciones, subset = c(Ano==2019 & Producto=="Flores" & Mes %in% c(7,8,9)))
# de lo que concluimos que el 19.13% del valor de exportaciones de flores de antioquia en el 2019 son del tercer trimestre del aÃ±o.

############Créditos##############
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
#No, extraÃ±amente el 16.67 de los clientes con historia crediticia buena son catalogados como malos

#El porcentaje de la cartera (en valor) que corresponde a créditos "malos" es menor para los clientes con "buen" historial crediticio?
mytable(credit_amount ~ credit_history*class, data=credit,ord="freq")
#Contrario con la cantidad de creditos los clientes con buen historial crediticio ctalogados como malos, el porcentake es 6.26 siendo menor para los creditos malos

#El porcentaje de la cartera (número de créditos) que corresponde a créditos "malos" es menor para los clientes con empleos mÃ¡s estables?
mytable(~ job, data=credit,subset=c(class == "1"),ord="freq")
#NO de hecho es locontrario A173 se creeria que es un trabajo mas estable 
#pero el 62% de los cretidos malos correspone a esta categoiria, En el caso deÃ± A174 si se cumple
mytable(~ job*class, data=credit,ord="freq")

#El porcentaje de la cartera (valor de los créditos) que corresponde a créditos "malos" es menor para los clientes con empleos mÃ¡s estables?
mytable(credit_amount ~ job*class, data=credit,ord="freq")
mytable(credit_amount~ job, data=credit,subset=c(class == "1"),ord="freq")
#No el porcentaje es mayor para los clientes con empleos mas estables
