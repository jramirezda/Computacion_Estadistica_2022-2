getwd()
setwd("C:/Users/Estudiante/Documents/CE")
getwd()

install.packages("readxl")
library(readxl)
help(read_excel)

#   str =  estructura
####### Libreria readxl  ###########
#ejm 1
plantulas1 <- read_excel("sample.xlsx",sheet=13,col_names=TRUE)
str(plantulas1)
head(plantulas1,7)


#ejm 2
plantulas2 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE)
str(plantulas2)

#Ejemplo 3
plantulas3 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_cols("A:E"))
str(plantulas3)


#Ejemplo 4
plantulas4 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_cols(1:5))
str(plantulas4)


#Ejemplo 5
plantulas5 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_rows(1:50))
str(plantulas5)


#Ejemplo 6
plantulas6 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range="A1:E50")
str(plantulas6)


#Ejemplo 7
plantulas7 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,n_max=35)
str(plantulas7)

#Ejemplo 8
plantulas8 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                         col_names=c("IdParcela","N_I","IdPlantula","N_i","Altura"))
str(plantulas8)


#Ejemplo 9
plantulas9 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                         col_names=c("IdParcela","N_I","IdPlantula","N_i","Altura"),
                         col_types=c("text","numeric","text","numeric","numeric"))
str(plantulas9)


#Ejemplo 10
plantulas10 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                          col_names=c("IdParcela","IdPlantula","N_i","Altura"),
                          col_types=c("text","skip","text","guess","numeric"))
str(plantulas10)

########### Libreria readr  ################

install.packages("readr")
library(readr)
help(read_delim)


#Ejemplo 10
stocks1 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE)
str(stocks1)


#Ejemplo 11
#Se leen los datos en el archivo stocks.dlm especificando que el separador decimal es "," y el separador de agrupamiento es ".".
stocks2 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."))
str(stocks2)
View(stocks2)

#Ejemplo 12
#Se leen los datos en el archivo stocks.dlm especificando el formato en el que se deben leer las variables.
help(cols)
stocks3 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f","D","d","d","d","d","n","d"))
str(stocks3)


#Ejemplo 13
#se leen los datos en el archivo stocks.dlm especificando el formato en el que se deben leer las variables. En particular, se especifica el formato como se debe leer la fecha de la que consta la variable número 2.
help(strptime)
stocks4 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"))
str(stocks4)
stocks4$A
stocks4$A[1:7]

#Ejemplo 14
#Se leen los datos en el archivo stocks.dlm personalizando los nombres de las variables.
stocks5 <- read_delim("stocks.dlm",delim=" ",
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"),skip=1,
                      col_names=c("Stock","Date","Open","High","Low","Close","Volume","AdjClose"))
str(stocks5)


#Ejemplo 15
#Se leen solo las primeras 500 filas de datos en el archivo stocks.dlm .
stocks6 <- read_delim("stocks.dlm",delim=" ",n_max=500,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"),skip=1,
                      col_names=c("Stock","Date","Open","High","Low","Close","Volume","AdjClose"))
str(stocks6)
dim(stocks6)

#Ejemplo 16
#Se leen los datos en el archivo stocks.dlm especificando el formato en el que se deben leer las variables. El formato de la tercera variable se especifica a partir de la inspección de los datos, y las variables septima y octava se excluyen.
stocks7 <- read_delim("stocks.dlm",delim=" ",
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"?","d","d","d","-","-"),
                      skip=1,col_names=c("Stock","Date","Open","High","Low","Close"))
str(stocks7)


#Ejemplo 17
#Solo se leen las variables que (originalmente) se llaman "A", "B", "C" y "F".

stocks8 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark = "."),
                      col_types=cols_only("A"="f","B"=col_date("%d%b%y"),"C"="d","F"="d"))
str(stocks8)

############  archivos de ancho fijo #############

#Ejemplo 18
#Se leen los datos en el archivo airrpm.txt, localizado en la libreria de trabajo y en el que las cuatro variables disponibles (Month, Available, Revenue y Unused) tienen anchos fijos e iguales a 6, 15, 10 y 9, respectivamente.

help(read_fwf)
airrpm1 <- read_fwf("airrpm.txt",fwf_cols(Month=6,Available=15,Revenue=10,Unused=9))
str(airrpm1)
airrpm1a <- read_fwf("airrpm.txt",fwf_cols(Month=8,Available=13,Revenue=12,Unused=9))

airrpm1==airrpm1a

#Ejemplo 19
#Se leen los datos en el archivo airrpm.txt especificando que el separador decimal es ",".

airrpm2 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    fwf_cols(Month=6,Available=15,Revenue=10,Unused=9))
str(airrpm2)
View(airrpm2)

#Ejemplo 20
#Se leen los datos en el archivo airrpm.txt especificando el formato de las variables.

help(cols)
help(strptime)
airrpm3 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    fwf_cols(Month=6,Available=15,Revenue=10,Unused=9),
                    col_types=cols(col_date("%b-%y"),"d","d","d"))
str(airrpm3)


#Ejemplo 21
#Se leen solo las primeras 200 filas de las variables Month y Revenue en el archivo airrpm.txt.

airrpm4 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    n_max=200,fwf_cols(Month=6,Available=15,Revenue=10,Unused=9),
                    col_types=cols_only(Month=col_date("%b-%y"),Revenue="d"))
str(airrpm4)



########## librera stringr ##################

install.packages("stringr")
library(stringr)
help(stringr)
Municipios <- read_excel("Municipios.xlsx")
str(Municipios)
head(Municipios,n=10)
tail(Municipios,n=10)

#para saber para que sirve cada uno mira la parte de expresiones regulares del R2


#Ejemplo 1
Municipios <- within(Municipios,{
  Municipio2 <- str_to_lower(Municipio)
  Municipio2 <- str_replace_all(Municipio2,"[^a-záéíóúüñ ]","")
  Municipio2 <- str_squish(Municipio2)
  Municipio2 <- str_to_title(Municipio2)
})
head(Municipios[,c("Municipio","Municipio2")],n=10)

Municipios <- within(Municipios,{
  Municipio <- Municipio2
  rm(Municipio2)
})
str(Municipios)

#grafico de la poblacion
within(Municipios,plot(Poblacion, Superficie, col=Dep))



#Ejemplo 2
Municipios <- within(Municipios,{
  Departamento2 <- str_to_lower(Departamento)
  Departamento2 <- str_replace_all(Departamento2,"[^a-záéíóúüñ ]","")
  Departamento2 <- str_squish(Departamento2)
  Departamento2 <- str_to_title(Departamento2)
})
head(Municipios[,c("Departamento","Departamento2")],n=10)
tail(Municipios[,c("Departamento","Departamento2")],n=10)

Municipios <- within(Municipios,{
  Departamento <- Departamento2
  rm(Departamento2)
})

dim(Municipios)
#Ejemplo 3
Municipios <- within(Municipios,{
  Region2 <- str_to_lower(Region)
  Region2 <- str_replace_all(Region2,"[^a-záéíóúüñ ]","")
  Region2 <- str_squish(Region2)
  Region2 <- str_to_title(Region2)
})
head(Municipios[,c("Region","Region2")],n=10)

Municipios <- within(Municipios,{
  Region <- str_to_lower(Region)
  Region <- str_replace_all(Region,"[^a-záéíóúüñ ]","")
  Region <- str_squish(Region)
  Region <- str_to_title(Region)
})
head(Municipios)
View(Municipios)

Municipios <- within(Municipios,{
  Region <- Region2
  rm(Region2)
})



#Ejemplo 4
Municipios <- within(Municipios,{
  Depmun=str_sub(Depmun,1,5)
  Tipo <- ifelse(str_sub(Depmun,3,5)=="001","Capital","Otro")
  Tipo2 <- ifelse(str_c(Dep,"001")==Depmun,"Capital","Otro")
  if(all(Tipo==Tipo2)) rm(Tipo2)
  Tipo <- ifelse(Depmun=="25001","Otro",Tipo)
})
View(Municipios)
head(Municipios[,c("Depmun","Tipo")],n=10)
tail(Municipios[,c("Depmun","Tipo")],n=10)
table(Municipios$Tipo)

#Ejemplo 5
Municipios <- within(Municipios,{
  denspobl <- Poblacion/Superficie
  Zona <- ifelse(Irural <= 40,"Urbano","Rural")
})

with(Municipios,summary(denspobl))
with(Municipios,table(Zona))
str(Municipios)

#Ejemplo 6
# ^| es para decir que comienza con san
# |to es paea decir que termina con ta o to
help(subset)
Santos <- subset(Municipios,str_detect(Municipio,"(^| )San( |ta |to )"),
                 select=c(Departamento,Depmun,Municipio))

str(Santos)
head(Santos,n=10)
tail(Santos,n=10)


#Ejemplo 7
Santos2 <- subset(Municipios,str_detect(Municipio,"(^| )San( |ta |to )"),
                  select=-c(Region,Irural,Poblacion,Superficie))

str(Santos2)
head(Santos2,n=10)
tail(Santos2,n=10)


# ^a comienza con a
# a$ termina con a
# .* cualquier cadena de caracteres
# str_to_lower(Municipio) coloca todo en minuscula
# chartr("áéíóú","aeiou" nos reemplaza las de tildes por sin tildes


#Ejemplo 8
vocales <- subset(Municipios,
                  str_detect(chartr("áéíóú","aeiou",str_to_lower(Municipio)),"^a.*a$|^e.*e$|^i.*i$|^o.*o$|^u.*u$"),
                  select=c(Dep,Departamento,Depmun,Municipio))
str(vocales)
head(vocales,n=30)
tail(vocales,n=10)


#Ejemplo 9
consonantes <- subset(Municipios,str_sub(str_to_lower(Municipio),1,1)==str_sub(Municipio,-1,-1) & 
                        str_detect(Municipio,"a$|e$|i$|o$|u$",negate=TRUE),
                      select=c(Dep,Departamento,Depmun,Municipio))
str(consonantes)
head(consonantes,n=10)
tail(consonantes,n=10)


#Ejemplo 10
Aes <- subset(Municipios,str_detect(Municipio,"^A..e.*"),
              select=-c(Poblacion,Superficie,Irural))

str(Aes)
head(Aes,n=10)
tail(Aes,n=10)


#ejemplo 10,1
Aes.1 <- subset(Municipios,str_detect(Municipio,"^(A|Á)..(e|é).*"),
              select=-c(Poblacion,Superficie,Irural))

str(Aes.1)
head(Aes.1,n=10)
tail(Aes.1,n=10)



#Ejemplo 11
Largos <- subset(Municipios,str_length(Municipio) >= quantile(str_length(Municipio),0.99),
                 select=c(Departamento,Depmun,Municipio))
str(Municipios)
str(Largos)
head(Largos)
tail(Largos)
nrow(Municipios)*0.01

#Ejemplo 12
Cortos <- subset(Municipios,str_length(Municipio) <= quantile(str_length(Municipio),0.01),
                 select=c(Departamento,Depmun,Municipio))

str(Cortos)
head(Cortos)
tail(Cortos)


#Ejemplo 13
vocales <- with(Municipios,str_count(str_to_lower(Municipio),"[aeiouáéíóúü]"))
table(vocales)

ejemplo=data.frame(Municipio=Municipios$Municipio, vocales)
ejemplo
str(ejemplo)
View(ejemplo)

#Ejemplo 14
palabras <- with(Municipios,str_count(Municipio," ") + 1)
table(palabras)


#Ejemplo 15
Mas4 <- subset(Municipios,str_count(Municipio," ") > 5)
Mas4


######     Estadísticas descriptivas #######


# is.na pregunta si es o no es un na, devuelve un valor logico
# as.matrix sirve para decirle que se tranforme en algo, en este caso un matrix

# en la funcion apply el 1 o el dos es para ver si se le aplica a las filas o alas columnas respectivamente

#Ejemplo 1
missings <- function(x) return(sum(is.na(x)))
apply(Municipios,2,missings)
apply(airquality,2,missings)


apply(Municipios,2,mean)
apply(airquality,2,mean)


#Ejemplo 2
table(apply(Municipios,1,missings))
table(apply(airquality,1,missings))



#Ejemplo 3
perdidos <- subset(airquality, is.na(Ozone))

str(perdidos)

perdi=subset(Municipios, is.na(Superficie))
View(perdi)

head(perdidos,n=10)
tail(perdidos,n=10)



#Ejemplo 4
summ <- function(x){
  x2 <- na.omit(x)
  y <- c(mean(x2),median(x2),sd(x2),sd(x2)/mean(x2),length(boxplot.stats(x2)$out),sum(is.na(x)))
  names(y) <- c("Mean","Median","Std.Dev","Coef.Var","Outliers","Missings")
  return(round(y,digits=2))
}

apply(Municipios[,c("Poblacion","Superficie","denspobl","Irural")],2,summ)
summary(Municipios)

#Ejemplo 5
summ2 <- function(x){
  x2 <- na.omit(x)   
  y <- c(length(unique(x2)),sum(is.na(x)))
  names(y) <- c("Levels","Missings")
  return(round(y,digits=2))
}

apply(Municipios[,c("Departamento","Depmun","Municipio","Region")],2,summ2)





#Ejemplo 6
stdize <- function(x) (x-mean(x,na.rm=TRUE))/sd(x,na.rm=TRUE)
Municipios2 <- Municipios
vars <- c("Poblacion","Superficie","Irural")

Municipios2[,vars] <- apply(Municipios[,vars],2,stdize)
str(Municipios2)
apply(Municipios2[,vars],2,summary)

#na.omit(Municipios) me quita los na que aparezcan
#Ejemplo 7
Municipios <- as.data.frame(na.omit(Municipios))
apply(Municipios,2,missings)
str(Municipios)

###### COMO GUARDAR ARCHIVOS ####

#R Data File
#    saveRDS(Municipios, file="Municipios.RDS")
#csv (Comma Separated Values)
write_csv(Municipios, "Municipios.csv")
#tsv (Tabular Separated Values)
write_tsv(Municipios, "Municipios.tsv")
#Text File
write_delim(Municipios, "Municipios.txt", delim="@")


Municipios=read_rds("Municipios.RDS")
######## Tablas de frecuencia #######
install.packages("dplyr")
library(dplyr)
source("mismacros.txt")

#Cuando ponemos "freq" o "-freq"le estamos diciendo que lo ordene por frecuencia, bien sea ascendente o descendente
# " con "level" los organiza alfabeticamente
# "  si le agragamos    ,cum=FALSE    lo que hace es quitarle la parte de frecuencia acumulada 
 
#Ejemplo 1
mytable(~ Departamento,data=Municipios,ord="level")

hola=mytable(~ Departamento,data=Municipios,ord="level")
View(hola)

mytable(~ Zona,data=Municipios,cum=FALSE)

fix(mytable)



#Ejemplo 2
mytable(Poblacion ~ Departamento,data=Municipios,ord="level")

mytable(Poblacion ~ Zona,data=Municipios,cum=FALSE)




#Ejemplo 3
mytable(Poblacion ~ Municipio,data=Municipios,subset={Dep=="13"},ord="freq")

mytable(Poblacion ~ Municipio,data=Municipios,subset=c(Dep=="13"),ord="-freq")

mytable(Poblacion ~ Zona,data=Municipios,subset=c(Dep=="13"),cum=FALSE)



#Ejemplo 4
mytable(Superficie/1000 ~ Departamento,data=Municipios,ord="freq")

mytable(Superficie ~ Departamento,data=Municipios,ord="-freq")

##### () tabla de dos vias  #####

#Ejemplo 5
mytable(~ Departamento*Zona,data=Municipios,ord="freq")

##### fin tabla dos vias  #####
#####   continuacion tablas frecuencia ######
#Ejemplo 6
mytable(Poblacion ~ Departamento*Zona,data=Municipios,ord="freq",digits=1)


#Ejemplo 7
mytable(Superficie ~ Departamento*Zona,data=Municipios,ord="freq",digits=1)

##### Libreria sqldf  #####

install.packages("sqldf")
library(sqldf)
help(sqldf)
Municipios <- readRDS("Municipios.RDS")

#Ejemplo 1
E1 <- sqldf("select   Departamento, Dep, Depmun, Municipio, Superficie, Poblacion
             from     Municipios
             where    Dep in ('05','17') and Poblacion > 20000
             order by Dep asc, Poblacion desc")

str(E1)
head(E1,n=10)
tail(E1,n=10)



#Ejemplo 2
E2 <- sqldf("select   Departamento, Dep, Depmun, Municipio, Superficie,
                      Poblacion, case when denspobl < 30 then 'Baja'
                                      when denspobl > 85 then 'Alta'
                                      else 'Media'
                                 end as denspoblC
             from     Municipios
             where    Dep not in ('15','68') and Superficie < 300
             order by Dep asc, Poblacion desc")

str(E2)
head(E2)
tail(E2)
table(E2$denspoblC)

#Ejemplo 3
sqldf("select   Depmun, count(*) as reps
       from     Municipios
       group by Depmun 
       having   reps > 1")

sqldf("select count(*) as tot_filas, count(distinct depmun) as tot_depmuns
       from   Municipios")


#Ejemplo 4
sqldf("select   Dep, Departamento, stdev(Superficie)/avg(Superficie) as cv
       from     Municipios 
       group by Dep, Departamento
       having   count(*) > 1 
       order by cv desc 
       limit    1")

sqldf("select   Dep, Departamento, stdev(Superficie)/avg(Superficie) as cv
       from     Municipios 
       group by Dep, Departamento
       having   count(*) > 1 
       order by cv desc")


sqldf("select   Dep, Departamento
       from     Municipios 
       group by Dep, Departamento
       having   count(*) > 1 
       order by stdev(Superficie)/avg(Superficie) ")

sqldf("select   Dep, Departamento
       from     Municipios 
       group by Dep, Departamento
       having   count(*) > 1 
       order by  stdev(Superficie)/avg(Superficie) desc
      limit  1")




#Ejemplo 5
sqldf("select   Dep, Departamento, stdev(Superficie)/avg(Superficie) as cv
       from     Municipios 
       group by Dep, Departamento
       having   count(*) > 1 
       order by cv 
       limit    1")


#Ejemplo 6
E6 <- sqldf("select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpob,
                      sum(Superficie) as totsup, sum(Poblacion)/sum(Superficie) as denspob,
                      sum(Irural*Poblacion)/sum(Poblacion) as Irural,
                      case when sum(Poblacion) > 1500000 then 'Grande'
                           when sum(Poblacion) < 300000 then 'Pequeño'
                           else 'Mediano'
                      end as totpobC
             from     Municipios
             group by Dep, Departamento
             order by totpob desc")

str(E6)
head(E6)
tail(E6)
table(E6$totpobC)

#Ejemplo 7
sqldf("select   Region
       from     Municipios
       group by Region
       order by sum(Superficie) desc
       limit    1")


sqldf("select   Region, sum(Superficie) as totalsup
       from     Municipios
       group by Region
       order by totalsup desc
       limit    1")

sqldf("select   Region
       from     Municipios
       group by Region
       order by sum(Superficie) asc
       limit    1")


sqldf("select   Region, sum(Superficie) as totalsup
       from     Municipios
       group by Region
       order by totalsup asc
       limit    1")


#Ejemplo 8
E8 <- sqldf("select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpob,
                      sum(Superficie) as totsup, sum(Poblacion)/sum(Superficie) as denspob
             from     Municipios
             where    Irural > 60
             group by Dep, Departamento
             order by totpob desc")

str(E8)
head(E8)
tail(E8)


#Ejemplo 9
sqldf("select   Region
       from     Municipios
       group by Region
       order by count(distinct Dep) desc
       limit    1")
sqldf("select   Region
       from     Municipios
       group by Region
       order by count( Dep) desc
       limit    1")
sqldf("select   Region
       from     Municipios
       group by Region
       order by count( *) desc
       limit    1")

sqldf("select   Region
       from     Municipios
       group by Region
       order by count(distinct Dep) desc")

sqldf("select   Region, count(distinct Dep) as numdep
       from     Municipios
       group by Region
       order by count(distinct Dep) desc")
uno=sqldf("select   Region, count(distinct Dep) as numdep
       from     Municipios
       group by Region
       order by count(distinct Dep) desc")

dos=sqldf("select   Region, count(Dep) as nummun
       from     Municipios
       group by Region
       order by count(Dep) desc")

sum(uno$numdep)
sum(dos$nummun)
#Ejemplo 10
E10 <- sqldf("select  Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpob, 
                      sum(Superficie) as totsup, sum(Poblacion)/sum(Superficie) as denspob
             from     Municipios
             group by Dep, Departamento
             having   totpob >= 650000 and totsup >= 10000
             order by denspob desc")

str(E10)
head(E10)
tail(E10)


#Ejemplo 11
E11 <- sqldf("select   Dep, Departamento, count(*) as nmunicipios, sum(Poblacion) as totpob, 
                       sum(Superficie) as totsup, sum(Poblacion)/sum(Superficie) as denspob
              from     Municipios
              where    Irural > 40
              group by Dep, Departamento
              having   totpob >= 650000 and totsup >= 10000
              order by denspob desc")

str(E11)
head(E11)
tail(E11)


#Ejemplo 12
Repetidos <- sqldf("select   Municipio, count(*) as veces
                    from     Municipios
                    group by Municipio
                    having   veces > 1
                    order by veces desc")

str(Repetidos)
head(Repetidos)
tail(Repetidos)

E12 <- sqldf("select   Municipio, Departamento, Dep, Depmun
              from     Municipios
              where    Municipio in (select Municipio 
                                     from   Repetidos)
              order by Municipio, Departamento")

str(E12)
head(E12,n=10)
tail(E12,n=10)




E12a <- sqldf("select   Municipio, Departamento, Dep, Depmun
               from     Municipios
               where    Municipio in (select   Municipio
                                      from     Municipios
                                      group by Municipio
                                      having   count(*) > 1)
               order by Municipio, Departamento")

all.equal(E12,E12a)


#Ejemplo 13
Repetidos <- sqldf("select   Region, Municipio, count(*) as veces
                    from     Municipios
                    group by Region, Municipio
                    having   veces > 1
                    order by veces desc")

str(Repetidos)
head(Repetidos)
tail(Repetidos)

E13 <- sqldf("select   Municipio, Region, Departamento, Dep, Depmun,Region||' '||Municipio as regmun
              from     Municipios
              where    Region||''||Municipio in (select Region||''||Municipio
                                                 from   Repetidos)
              order by Municipio asc, Region asc")

str(E13)
head(E13,n=10)
tail(E13,n=10)


E13a <- sqldf("select   Municipio, Region, Departamento, Dep, Depmun
               from     Municipios
               where    Region||''||Municipio in (select   Region||''||Municipio
                                                  from     Municipios
                                                  group by Region, Municipio
                                                  having   count(*) > 1)
               order by Municipio asc, Region asc")

str(E13a)

all.equal(E13,E13a)
#no estan iguales porque se le agregó una columna a el primero 


# or es el operador logico para o
# % significa cualquier cosa
#Ejemplo 14
E14 <- sqldf("select   Dep, Departamento, Municipio, Depmun
              from     Municipios
              where    Municipio like 'A%' or
                       Municipio like 'Á%' or 
                       Municipio like '%o' or
                       Municipio like '%ó'
              order by Depmun")

str(E14)
head(E14)
tail(E14)


#Ejemplo 15
E15 <- sqldf("select   Dep, Departamento, Municipio, Depmun
              from     Municipios
              where    Municipio like 'A%o' or
                       Municipio like 'A%ó' or
                       Municipio like 'Á%o'
              order by Depmun")

str(E15)
head(E15)
tail(E15)


#Ejemplo 16
E16 <- sqldf("select   Dep, Departamento, Municipio, Depmun
              from     Municipios
              where    Municipio like '_e_e%' or 
                       Municipio like '_é_e%' or
                       Municipio like '_e_é%'
              order by Depmun")

str(E16)
head(E16)
tail(E16)


#Ejemplo 17
E17 <- sqldf("select   Dep, Departamento, Municipio, Depmun
              from     Municipios
              where    Municipio like '% %'
              order by Depmun")

E17 <- sqldf("select   Dep, Departamento, Municipio, Depmun
              from     Municipios
              where    Municipio like '% % %'
              order by Depmun")

str(E17)
head(E17)
tail(E17)


#Ejemplo 18
Estaciones <- read_excel("Estaciones.xlsx")
str(Estaciones)

E18 <- sqldf("select distinct Depmun
              from   Estaciones")
str(E18)
head(E18)
tail(E18)


#Ejemplo 19
Emon <- sqldf("select   Depmun, count(*) as nem 
               from     Estaciones
               group by Depmun")

E19 <- sqldf("select Municipios.*, case when nem is null then 0 
                                        else nem 
                                   end as nest
              from   Municipios left join Emon on (Municipios.Depmun = Emon.Depmun)")

str(E19) 
head(E19)
tail(E19)


#Ejemplo 20
E20 <- sqldf("select   Municipios.*
              from     Municipios left join Emon on (Municipios.Depmun = Emon.Depmun)
              where    nem is NULL
              order by Depmun")

E20a <- sqldf("select   Municipios.*
               from     Municipios
               where    Depmun not in (select distinct Depmun
                                       from   Estaciones)
               order by Depmun")

all.equal(E20,E20a)

str(E20) 
head(E20)
tail(E20)



#Ejemplo 21
E21 <- sqldf("select   Estaciones.*, Municipio, Departamento, Dep
              from     Estaciones inner join Municipios on (Estaciones.Depmun = Municipios.Depmun)
              where    elev <= 2000
              order by Depmun, codigo")

E21a <- sqldf("select   Estaciones.*, Municipio, Departamento, Dep
               from     Estaciones left join Municipios on (Estaciones.Depmun = Municipios.Depmun)
               where    elev <= 2000
               order by Depmun, codigo")

all.equal(E21,E21a)

str(E21)



#####  PRODUCTOS CARTESIANOS - inner join - con sql######

A <- data.frame(id=c(1,2,2,3),cod=c(23,65,60,87),name=c("Leia","Luke","Yoda","Hank"))
B <- data.frame(id=c(2,3,4),cod=c(65,87,29),age=c(23,20,25))
A
B

sqldf("select * 
       from     A inner join B on (A.id=B.id and A.cod=B.cod)")

sqldf("select * 
       from     B inner join A on (B.id=A.id and B.cod=A.cod)")

sqldf("select * 
       from     A left join B on (A.id=B.id and A.cod=B.cod)")

sqldf("select * 
       from     A right join B on (A.id=B.id and A.cod=B.cod)")

sqldf("select * 
       from     B left join A on (B.id=A.id and B.cod=A.cod)")

####### Libreria dplyr  ########
install.packages("dplyr")
library(dplyr)
help(dplyr)

#Ejemplo 1
e1 <- Municipios %>%
  select(Departamento,Dep,Depmun,Municipio,Superficie, Poblacion) %>%
  filter(Dep %in% c("05","17") & Poblacion > 20000) %>%
  arrange(Dep,desc(Poblacion)) %>% 
  as.data.frame()
e1a <- Municipios %>%
  filter(Dep %in% c("05","17") & Poblacion > 20000) %>%
  arrange(Dep,desc(Poblacion)) %>% 
  select(Departamento,Dep,Depmun,Municipio,Superficie, Poblacion) %>%
  as.data.frame()

all.equal(e1,E1,check.attributes=FALSE)
all.equal(e1,e1a,check.attributes=FALSE)

str(e1) 
head(e1,n=10)
tail(e1,n=10)


#Ejemplo 2
e2 <- Municipios %>%
  filter(Dep!="15" & Dep!="68" & Superficie < 300) %>%
  mutate(denspoblC=case_when(denspobl > 85 ~ "Alta",
                             denspobl < 30 ~ "Baja",
                             TRUE ~ "Media")) %>%
  arrange(Dep,desc(Poblacion)) %>%
  select(Departamento,Dep,Depmun,Municipio,Superficie,Poblacion,denspoblC) %>%
  as.data.frame()

all.equal(e2,E2,check.attributes=FALSE)

str(e2) 
str(E2) 
head(e2,n=10)
tail(e2,n=10)

#Ejemplo 3
Municipios %>% 
  group_by(Depmun) %>%
  summarise(repetidos=n()) %>% 
  filter(repetidos > 1)

Municipios %>%
  summarise(tot_filas=n(),tot_depmuns=n_distinct(Depmun))

#Ejemplo 4
Municipios %>% 
  group_by(Dep,Departamento) %>%
  summarise(mun=n(),cv=sd(Superficie)/mean(Superficie))%>%
  filter(mun > 1) %>% 
  arrange(desc(cv)) %>% 
  filter(row_number()==1) %>% 
  as.data.frame()


#Ejemplo 5


#Ejemplo 6

#Ejemplo 7


#Ejemplo 8


#Ejemplo 9

#Ejemplo 10


#Ejemplo 11


#Ejemplo 12

#Ejemplo 13


#Ejemplo 14


#Ejemplo 15

#Ejemplo 16


#Ejemplo 17


#Ejemplo 18

#Ejemplo 19


#Ejemplo 20


#Ejemplo 21

#Ejemplo 


#Ejemplo 


#Ejemplo

#Ejemplo 


#Ejemplo 


#Ejemplo

#Ejemplo 


#Ejemplo 


#Ejemplo

#Ejemplo 


#Ejemplo 


#Ejemplo 




























