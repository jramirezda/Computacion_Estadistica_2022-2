#clase 1 R#
#importacion de datos 
install.packages("readxl")
library(readxl)
install.packages("rlang")
library(rlang)
install.packages("lifecycle")
library(lifecycle)
sessionInfo()
remove.packages("rlang")


help(read_excel)
plantulas1 <- read_excel("sample.xlsx",sheet=13,col_names=TRUE)
str(plantulas1)
plantulas2 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE)
str(plantulas2)
plantulas3 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_cols("A:E"))
str(plantulas3)

#metodos
View(plantulas1)
View(plantulas2)
View(plantulas3)
?View
head(plantulas1, n=5)
?head
tail(plantulas1, n=5)
?tail
nrow(plantulas2)
?nrow
dim(plantulas2)
?dim


#clase 2
#Se leen los datos en las columnas "A" a la "E" de la hoja Plantulas del libro de Excel sample.xlsx.
plantulas4 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_cols(1:5))
str(plantulas4)

#Ejemplo 5
#Se leen los datos en las filas 2 a la 50 de la hoja Plantulas del libro de Excel sample.xlsx.

plantulas5 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_rows(1:50))
str(plantulas5)

#Ejemplo 6
#Se leen los datos en el rango "A1:E50" de la hoja Plantulas del libro de Excel sample.xlsx.

plantulas6 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range="A1:E50")
str(plantulas6)

colnames(plantulas6)
?colnames
row.names(plantulas6)
?row.names
View(plantulas6)
#Ejemplo 7
#Se leen solo las primeras 35 filas de datos en la hoja Plantulas del libro de Excel sample.xlsx.

plantulas7 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,n_max=35)
str(plantulas7)



#Ejemplo 8
#Se leen los datos en la hoja Plantulas del libro de Excel sample.xlsx dándole nombres personalizados a las variables.

plantulas8 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                         col_names=c("IdParcela","N_I","IdPlantula","N_i","Altura"))
str(plantulas8)

#Ejemplo 9
#Se leen los datos en la hoja Plantulas del libro de Excel sample.xlsx, dándole nombres personalizados a las variables y leyendo estas últimas con formato text, numeric, text, numeric y numeric, respectivamente.
#"skip", "guess", "logical", "numeric", "date", "text" or "list". son los tipos que puedo usar 
help(read_excel)
plantulas9 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                         col_names=c("IdParcela","N_I","IdPlantula","N_i","Altura"),
                         col_types=c("text","numeric","text","numeric","numeric"))
str(plantulas9)
#Ejemplo 10
#Se leen los datos en la hoja Plantulas del libro de Excel sample.xlsx, dándole nombres personalizados a las variables y leyendo estas últimas con formato text, skip, text, guess y numeric, respectivamente.
#Por lo tanto, la segunda variable se excluye y el tipo de la cuarta variable se especifica a partir de una inspección de los datos.

plantulas10 <- read_excel("sample.xlsx",sheet="Plantulas",skip=1,
                          col_names=c("IdParcela","IdPlantula","N_i","Altura"),
                          col_types=c("text","skip","text","guess","numeric"))
str(plantulas10)
#x<-c("cosas",32,TRUE,("cosas"))

install.packages("readr")
library(readr)
help(read_delim)

#ejemplo 11
stocks1 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE)
str(stocks1)
head(stocks1)

#ejmplo 12
stocks2 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."))#, ceparador decimal . ceparador de agrupamiento  
str(stocks2)

#ejemplo 13 
help(cols)
stocks3 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f","D","d","d","d","d","n","d"))
str(stocks3)
 
#ejemplo 14 
help(strptime)
stocks4 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"))
str(stocks4)

#ejemplo 15 
?strptime
stocks5 <- read_delim("stocks.dlm",delim=" ",
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"),skip=1,
                      col_names=c("Stock","Date","Open","High","Low","Close","Volume","AdjClose"))
#%d/%b/%y o %d-%b-%y son otras opciones
str(stocks5)
stocks5$Date


#ejemplo 16 
stocks6 <- read_delim("stocks.dlm",delim=" ",n_max=500,
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"d","d","d","d","n","d"),skip=1,
                      col_names=c("Stock","Date","Open","High","Low","Close","Volume","AdjClose"))
str(stocks6)

#ejemplo 17 
stocks7 <- read_delim("stocks.dlm",delim=" ",
                      locale=locale(decimal_mark=",",grouping_mark="."),
                      col_types=cols("f",col_date("%d%b%y"),"?","d","d","d","-","-"),
                      skip=1,col_names=c("Stock","Date","Open","High","Low","Close"))
#"-" es el abrebiado del skip para saltar una columna.
str(stocks7)
#cols_only(solamente leame las que le digo y las demas omitalas)

#ejemplo 18 
stocks8 <- read_delim("stocks.dlm",delim=" ",col_names=TRUE,
                      locale=locale(decimal_mark=",",grouping_mark = "."),
                      col_types=cols_only("A"="f","B"=col_date("%d%b%y"),"C"="d","F"="d"))
str(stocks8)

#ejemplo 19 
#Se leen los datos en el archivo airrpm.txt, localizado en la libreria de trabajo 
#y en el que las cuatro variables disponibles (Month, Available, Revenue y 
#Unused) tienen anchos fijos e iguales a 6, 15, 10 y 9, respectivamente.

help(read_fwf)
airrpm1 <- read_fwf("airrpm.txt",fwf_cols(Month=6,Available=15,Revenue=10,Unused=9))
str(airrpm1)
#la fila depende de la cantidad de espacios es el separador 

#ejemplo 19,5   

airrpmer <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    fwf_cols(Month=7,Available=14,Revenue=10,Unused=9))
str(airrpmer)

#ejemplo 20 
airrpm2 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    fwf_cols(Month=6,Available=15,Revenue=10,Unused=9))
str(airrpm2)

#ejemplo 21 
help(cols)
help(strptime)
airrpm3 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    fwf_cols(Month=6,Available=15,Revenue=10,Unused=9),
                    col_types=cols(col_date("%b-%y"),"d","d","d"))
str(airrpm3)

#ejemplo 22 
airrpm4 <- read_fwf("airrpm.txt",locale=locale(decimal_mark=","),
                    n_max=200,fwf_cols(Month=6,Available=15,Revenue=10,Unused=9),
                    col_types=cols_only(Month=col_date("%b-%y"),Revenue="d"))
str(airrpm4)



## tarea hacer los tres jercicios






##creacion y modificacion de variables 
install.packages("stringr")
library(stringr)
help(stringr)

Municipios <- read_excel("Municipios.xlsx")
str(Municipios)
head(Municipios,n=10)
tail(Municipios,n=10)
View(Municipios)
dim(Municipios)

#Ejemplo 1
#Se hace "limpieza" en los nombres de los municipios, es decir,

#Se eliminan caracteres especiales
#Se eliminan espacios al inicio y al final
#Se reemplazan espacios múltiples por sencillos
#Se escriben en letras minúsculas excepto en la inicial de cada palabra

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
head(Municipios)
?str_squish
?str_to_lower
?str_replace_all
?str_to_title

#grafico de la poblacion 
within(Municipios, plot(Poblacion,Superficie, col=Dep))

#ejemplo 2 
Municipios <- within(Municipios,{
  Departamento2 <- str_to_lower(Departamento)
  Departamento2 <- str_replace_all(Departamento2,"[^a-záéíóúüñ ]","")
  Departamento2 <- str_squish(Departamento2)
  Departamento2 <- str_to_title(Departamento2)
})
head(Municipios[,c("Departamento","Departamento2")],n=10)

Municipios <- within(Municipios,{
  Departamento <- Departamento2
  rm(Departamento2)
})
head(Municipios)
?str_to_title
#ejemplo 3 
Municipios <- within(Municipios,{
  Region <- str_to_lower(Region)
  Region <- str_replace_all(Region,"[^a-záéíóúüñ ]","")
  Region <- str_squish(Region)
  Region <- str_to_title(Region)
})
head(Municipios)
Municipios<-within(Municipios,{
  Region<- str_replace_all(Region,"Región ",""
  )})
head(Municipios)

#ejemplo 6 
?str_detect
help(subset)
Santos <- subset(Municipios,str_detect(Municipio,"(^| )San( |ta |to )"),
                 select=c(Departamento,Depmun,Municipio)) 
#^ significa comienza con" " o san luego del san puede venir el " " o ta o to
#no estan entre comillas
#subset argumentos, el dataframe, filas que va a usae con T y F y select nos quedamos con las columnas o todas.
str(Santos)
head(Santos,n=10)
tail(Santos,n=10)

#ejemplo 7 
Santos2 <- subset(Municipios,str_detect(Municipio,"(^| )San( |ta |to )"),
                  select=-c(Region,Irural,Poblacion,Superficie))
#el menos en el selec le estoy quitando las que quiero quitar.
str(Santos2)
head(Santos2,n=10)
tail(Santos2,n=10)

#ejemplo 8 
#el signo $ significa termina con. a$ significa que termina con a. * significa una cadena de texto de cualquier longitud
vocales <- subset(Municipios,                       #str_to_lower pone todo en minuscula y luego cambia los de las tildes.
                  str_detect(chartr("áéíóú","aeiou",str_to_lower(Municipio)),"^a.*a$|^e.*e$|^i.*i$|^o.*o$|^u.*u$"),
                  select=c(Dep,Departamento,Depmun,Municipio))
str(vocales)
head(vocales,n=10)
tail(vocales,n=10)

?str_sub
#ejemplo 9                              #extraiga desde el primero hasta el primero y == compare con el ultimo      
consonantes <- subset(Municipios,str_sub(str_to_lower(Municipio),1,1)==str_sub(Municipio,-1,-1) & 
                        str_detect(Municipio,"a$|e$|i$|o$|u$",negate=TRUE),
                      select=c(Dep,Departamento,Depmun,Municipio))
#negando las vocales
str(consonantes)
head(consonantes,n=10)
tail(consonantes,n=10)

#ejemplo 10 
#Conjunto de datos con todas las variables excepto Poblacion, Superficie y Irural, y con todos los municipios cuyos nombres tienen "A" como primera letra y "e" como cuarta letra.
Aes <- subset(Municipios,str_detect(Municipio,"^A..e.*")  ,
              select=-c(Poblacion,Superficie,Irural))

str(Aes)
head(Aes,n=10)
tail(Aes,n=10)

#ejemplo 10,1
Aes.1 <- subset(Municipios,str_detect(Municipio,"^(A|Á)..(e|é).*")  ,
              select=-c(Poblacion,Superficie,Irural))

str(Aes.1)
head(Aes.1,n=10)
tail(Aes.1,n=10)

#ejemplo 11
Largos <- subset(Municipios,str_length(Municipio) >= quantile(str_length(Municipio),0.99),
                 select=c(Departamento,Depmun,Municipio))

str(Largos)
head(Largos)
tail(Largos)

dim(Municipios)
nrow(Municipios)*0.01

#ejemplo 12
Cortos <- subset(Municipios,str_length(Municipio) <= quantile(str_length(Municipio),0.01),
                 select=c(Departamento,Depmun,Municipio))

str(Cortos)
head(Cortos)
tail(Cortos)

#ejemplo 13
cvocales <- with(Municipios,str_count(str_to_lower(Municipio),"[aeiouáéíóúü]"))
table(cvocales)

eje<- data.frame(Municipio=Municipios$Municipio,cvocales)
eje
str(eje)
View(eje)
#ejemplo 14 
palabras <- with(Municipios,str_count(Municipio," ") + 1)
table(palabras)

#ejemplo 15 
?str_c
Municipios <- within(Municipios,{
Tipo <- ifelse(str_sub(Depmun,3,5)=="001","Capital","Otro")
Tipo2 <- ifelse(str_c(Dep,"001")==Depmun,"Capital","Otro")
if(all(Tipo==Tipo2)) rm(Tipo2)
Tipo <- ifelse(Depmun=="25001","Otro",Tipo)
})
str(Municipios)
head(Municipios[,c("Depmun","Tipo")],n=10)
tail(Municipios[,c("Depmun","Tipo")],n=10)

table(Municipios$Tipo)


#ejemplo 
Municipios <- within(Municipios,{
  denspobl <- Poblacion/Superficie
  Zona <- ifelse(Irural <= 40,"Urbano","Rural")
})

with(Municipios,summary(denspobl))
with(Municipios,table(Zona))
str(Municipios)
View(Municipios)

#descriptivas 
#ejemplo 1 Cuales variables del conjunto de datos Municipios tienen valores perdidos o missings? Y del conjunto de datos airquality?
missings <- function(x) return(sum(is.na(x)))
apply(Municipios,2,missings)
apply(airquality,2,missings)

#ejemplo 2 
table(apply(Municipios,1,missings))
table(apply(airquality,1,missings))

#ejejmplo 2,1 
table(apply(Municipios,1,mean))
table(apply(airquality,1,mean))

#ejemplo 2,2
table(apply(Municipios,1,missings))
table(apply(airquality,1,missings))

#ejemplo 3
perdidos <- subset(airquality, is.na(Ozone))

str(perdidos)
head(perdidos,n=10)
tail(perdidos,n=10)

#ejemplo 3,1
Cortos <- subset(Municipios,as.na())
#ejemplo 4
summ <- function(x){
  x2 <- na.omit(x)
  y <- c(mean(x2),median(x2),sd(x2),sd(x2)/mean(x2),length(boxplot.stats(x2)$out),sum(is.na(x)))
  names(y) <- c("Mean","Median","Std.Dev","Coef.Var","Outliers","Missings")
  return(round(y,digits=2))
}
summary(Municipios)
apply(Municipios[,c("Poblacion","Superficie","denspobl","Irural")],2,summ)

#ejemplo 4,1
summis <- function(x){
  x2 <- na.omit(x)
  y <- c(mean(x2),median(x2),sd(x2),sd(x2)/mean(x2),length(boxplot.stats(x2)$out),sum(is.na(x)),(length(boxplot.stats(x2)$out/length(x2))*100),sum(is.na(x))/nrow(Municipios)*100)
  names(y) <- c("Mean","Median","Std.Dev","Coef.Var","Outliers","Missings","%out","%missin")
  return(round(y,digits=2))
}
summary(Municipios)
apply(Municipios[,c("Poblacion","Superficie","denspobl","Irural")],2,summis)

#ejemplo 5
summ2 <- function(x){
  x2 <- na.omit(x)   
  y <- c(length(unique(x2)),sum(is.na(x)))
  names(y) <- c("Levels","Missings")
  return(round(y,digits=2))
}

apply(Municipios[,c("Departamento","Depmun","Municipio","Region")],2,summ2)

#ejemplo 5,1
summ2.1 <- function(x,y){
  x2 <- na.omit(x)   
  y <- c(length(unique(x2)),sum(is.na(x)))
  names(y) <- c("Levels","Missings")
  return(round(y,digits=y))
}
apply(Municipios[,c("Departamento","Depmun","Municipio","Region")],2,summ2.1, y=4)

summ.1 <- function(x,y){
  x2 <- na.omit(x)
  y <- c(mean(x2),median(x2),sd(x2),sd(x2)/mean(x2),length(boxplot.stats(x2)$out),sum(is.na(x)))
  names(y) <- c("Mean","Median","Std.Dev","Coef.Var","Outliers","Missings")
  return(round(y,digits=y))
}
summary(Municipios)
apply(Municipios[,c("Poblacion","Superficie","denspobl","Irural")],2,y=3,summ.1)


#ejemplo 7
Municipios <- as.data.frame(na.omit(Municipios))
apply(Municipios,2,missings)

#ejemplo 8
saveRDS(Municipios, file="Municipios.RDS")
#ejemplo 9 
write_csv(Municipios, "Municipios.csv")
#ejemplo 10 
write_tsv(Municipios, "Municipios.tsv")
write_delim(Municipios, "Municipios.txt", delim="@")

?read_rds
Municipios<-read_rds("Municipios.RDS")
str(Municipios)

##tablas de frecuencia 
install.packages("dplyr")
library(dplyr)
source("mismacros.txt")


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
##               esto es para decirle que no he terminado de dar instrucciones.
str(Municipios)
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

## en este caso el selec debe ir luego del mutate porque acá crea denspolC.
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
## summarise resulme en este caso n() es el contar filas.
Municipios %>% 
  group_by(Depmun) %>%
  summarise(repetidos=n()) %>% 
  filter(repetidos > 1)
# n_distinct cuenta los diferentes 
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


## 4,1
Municipios %>% 
  group_by(Dep,Departamento) %>%
  summarise(mun=n(),cv=sd(Superficie)/mean(Superficie))%>%
  filter(mun > 1) %>% 
  arrange(desc(cv)) %>% 
  head(n=1) %>% 
  as.data.frame()
## Ejemplo 5
Municipios %>% 
  group_by(Dep,Departamento) %>%
  summarise(mun=n(),cv=sd(Superficie)/mean(Superficie)) %>%
  filter(mun > 1) %>% 
  arrange(cv) %>% 
  filter(row_number()==1) %>% 
  as.data.frame()

Municipios %>% 
  group_by(Dep,Departamento) %>%
  summarise(mun=n(),cv=sd(Superficie)/mean(Superficie)) %>%
  filter(mun > 1) %>% 
  arrange(cv) %>% 
  head(n=1) %>% 
  as.data.frame()
## ejemplo 6 
e6 <- Municipios %>%
  group_by(Dep,Departamento) %>%
  summarise(nmunicipios=n(),totpob=sum(Poblacion), 
            totsup=sum(Superficie),denspob=totpob/totsup,
            Irural=sum(Irural*Poblacion)/totpob,
            totpobC=case_when(totpob > 1.5e6 ~ "Grande",
                              totpob < 3e5 ~ "Pequeño",
                              TRUE ~ "Mediano")) %>%
  arrange(desc(totpob)) %>% 
  as.data.frame()

all.equal(e6,E6,check.attributes=FALSE)

str(e6)



?sum
##na.rm=TRUE  quita el faltante y calcula.


## Ejemplo 7
Municipios %>% 
  group_by(Region) %>%
  summarise(sup=sum(Superficie)) %>% 
  arrange(desc(sup)) %>% 
  filter(row_number()==1) %>% 
  as.data.frame()

Municipios %>% 
  group_by(Region) %>%
  summarise(sup=sum(Superficie)) %>% 
  arrange(desc(sup)) %>% 
  head(n=1) 

##Ejempo 8 
e8 <- Municipios %>%
  filter(Irural > 60) %>%
  group_by(Dep,Departamento) %>%
  summarise(nmunicipios=n(),totpob=sum(Poblacion),totsup=sum(Superficie),
            denspob=totpob/totsup) %>%
  arrange(desc(totpob)) %>% 
  as.data.frame()

all.equal(e8,E8,check.attributes=FALSE)
str(e8)

## Ejmplo 9 
Municipios %>% 
  group_by(Region) %>%
  summarise(Deps=n_distinct(Dep)) %>%
  arrange(desc(Deps)) %>%
  filter(row_number()==1) %>% 
  as.data.frame()

Municipios %>% 
  group_by(Region) %>%
  summarise(Deps=n_distinct(Dep)) %>%
  arrange(desc(Deps)) %>%
  head(n=1)

Municipios %>% 
  group_by(Region) %>%
  summarise(Deps=n_distinct(Dep)) %>%
  arrange(Deps) %>%
  tail(n=1)

##Ejemplo 10 
e10 <- Municipios %>%
  group_by(Dep,Departamento) %>%
  summarise(nmunicipios=n(),totpob=sum(Poblacion),totsup=sum(Superficie),
            denspob=totpob/totsup) %>%
  filter(totpob >= 650000 & totsup >= 10000) %>%
  arrange(desc(denspob)) %>% 
  as.data.frame()

all.equal(e10,E10,check.attributes=FALSE)
str(e10)

## Ejemplo 11
e11 <- Municipios %>%
  filter(Irural > 40) %>%
  group_by(Dep,Departamento) %>%
  summarise(nmunicipios=n(),totpob=sum(Poblacion),totsup=sum(Superficie),
            denspob=totpob/totsup) %>%
  filter(totpob >= 650000 & totsup >= 10000) %>%
  arrange(desc(denspob)) %>%
  as.data.frame()

all.equal(e11,E11,check.attributes=FALSE)
str(e11)

#ejemplo 12 

original <- Sys.getlocale("LC_COLLATE")
Sys.setlocale("LC_COLLATE", "C")

Repetidos <- Municipios %>%
  group_by(Municipio) %>%
  summarise(veces = n()) %>%
  filter(veces > 1) %>%
  arrange(desc(veces)) %>%
  as.data.frame()

str(Repetidos) 
head(Repetidos)

e12 <- Municipios %>%
  select(Municipio,Departamento,Dep,Depmun) %>%
  filter(Municipio %in% with(Repetidos,Municipio)) %>%
  arrange(Municipio,Departamento) %>%
  as.data.frame()

Sys.setlocale("LC_COLLATE", original)

all.equal(e12,E12,check.attributes=FALSE)
str(e12)
head(E12, n=10)
head(e12, n=10)
tail(e12)


#ejemplo 13 

original <- Sys.getlocale("LC_COLLATE")
Sys.setlocale("LC_COLLATE", "C")

Repetidos <- Municipios %>%
  group_by(Region,Municipio) %>%
  summarise(veces = n()) %>%
  filter(veces > 1) %>%
  arrange(desc(veces)) %>%
  as.data.frame()

str(Repetidos) 

e13 <- Municipios %>%
  select(Municipio,Region,Departamento,Dep,Depmun) %>%
  filter(str_c(Region,Municipio) %in% with(Repetidos,str_c(Region,Municipio))) %>%
  arrange(Municipio,Region) %>%
  as.data.frame()

Sys.setlocale("LC_COLLATE", original)

all.equal(e13,E13,check.attributes=FALSE)
str(e13)

## Ejemplo 14 
library(stringr)
e14 <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_detect(Municipio,"^[AÁ]") | str_detect(Municipio,"[oó]$")) %>%
  as.data.frame()

e14a <- Municipios %>% 
  select(Dep,Departamento,Municipio, Depmun) %>% 
  filter(str_detect(Municipio,"^[AÁ]|[oó]$")) %>%
  as.data.frame()

all.equal(e14,e14a,check.attributes=FALSE)
all.equal(e14,E14,check.attributes=FALSE)
str(e14) 
head(e14)

#Ejemplo 15 
e15 <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_detect(Municipio,"^[AÁ]") & str_detect(Municipio,"[oó]$")) %>%
  as.data.frame()

e15a <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_detect(Municipio,"^[AÁ].*[oó]$")) %>%
  as.data.frame()

all.equal(e15,e15a,check.attributes=FALSE)
all.equal(e15,E15,check.attributes=FALSE)
str(e15) 
head(e15)

#ejemplo 16 
e16 <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_sub(Municipio,2,2) %in% c("e","é") & str_sub(Municipio,4,4) %in% c("e","é")) %>%
  as.data.frame()

e16a <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_detect(Municipio,"^.[eé].[eé].*")) %>%
  as.data.frame()

all.equal(e16,e16a,check.attributes=FALSE)
all.equal(e16,E16,check.attributes=FALSE)
str(e16)
## ejemplo 17 
e17 <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_count(Municipio," ")>=1) %>%
  as.data.frame()

e17a <- Municipios %>% 
  select(Dep,Departamento,Municipio,Depmun) %>% 
  filter(str_detect(Municipio,".* .*")) %>%
  as.data.frame()

all.equal(e17,e17a,check.attributes=FALSE)
all.equal(e17,E17,check.attributes=FALSE)
str(e17) 
head(e17)

## iner 
A <- data.frame(id=c(1,2,2,3),cod=c(23,65,60,87),name=c("Leia","Luke","Yoda","Hank"))
B <- data.frame(id=c(2,3,4),cod=c(65,87,29),age=c(23,20,25))
A
B

A %>% inner_join(B,by=c("id"="id","cod"="cod"))

B %>% inner_join(A,by=c("id"="id","cod"="cod"))

A %>% left_join(B,by=c("id"="id","cod"="cod"))

A %>% right_join(B,by=c("id"="id","cod"="cod"))

A %>% full_join(B,by=c("id"="id","cod"="cod"))

Estaciones
##ejemplo 18 
e18 <- Estaciones %>% 
  distinct(Depmun) %>% as.data.frame()

all.equal(e18,E18,check.attributes=FALSE)
head(e18)

## Ejemplo 19 
Emon <- Estaciones %>% 
  group_by(Depmun) %>%
  summarise(nem=n())

e19 <- Municipios %>%
  left_join(Emon,by=c("Depmun"="Depmun")) %>%
  mutate(nest=case_when(is.na(nem) ~ 0L,TRUE ~ nem)) %>%
  select(everything(Municipios),nest) %>%
  as.data.frame()
#0L es 0 entero.
all.equal(e19,E19,check.attributes=FALSE)
str(e19)

#ejemplo 20 e20 <- Municipios %>%
e20 <- Municipios %>%
  left_join(Emon,by=c("Depmun"="Depmun")) %>%
  filter(is.na(nem)) %>% select(everything(Municipios))%>%
  arrange(Depmun) %>%
  as.data.frame()

e20a <- Municipios %>% arrange(Depmun) %>%
  filter(!(Depmun %in% with(Estaciones,Depmun))) %>%
  as.data.frame()

all.equal(e20,e20a,check.attributes=FALSE)
all.equal(e20,E20,check.attributes=FALSE)

str(e20) 
head(e20)
tail(e20)

## ejemplo 21 
e21 <- Estaciones %>%
  inner_join(Municipios,by=c("Depmun"="Depmun")) %>%
  filter(ELEV <= 2000) %>%
  select(everything(Estaciones),Municipio,Departamento,Dep)%>%
  arrange(Depmun,CODIGO) %>%
  as.data.frame()

e21a <- Estaciones %>%
  left_join(Municipios,by=c("Depmun"="Depmun")) %>%
  filter(ELEV <= 2000) %>%
  select(everything(Estaciones),Municipio,Departamento,Dep) %>%
  arrange(Depmun,CODIGO) %>%
  as.data.frame()



all.equal(e21,e21a,check.attributes=FALSE)
all.equal(e21,E21,check.attributes=FALSE)


## GGplot
install.packages("ggplot2")
library(ggplot2)
library(readxl)
help(ggplot2)

advertising <- read_excel("Advertising.xlsx")
str(advertising)


##Ejemplo 1 
ggplot(advertising,aes(x=TV,y=sales)) +
  geom_point() +
  labs(title="Ventas versus inversión en publicidad en TV",x="Publicidad en TV",y="Ventas") +
  theme_light()
##Ejemplo 2 
ggplot(advertising,aes(x=TV,y=sales)) +
  geom_point(color="green",shape=16,size=3.5) +
  labs(title="Ventas versus inversión en publicidad en TV",x="Publicidad en TV",y="Ventas") +
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  theme(
    plot.title=element_text(family="sans",face="italic",size=10,vjust=0.5,hjust=0.5,
                            color="blue",angle=0),
    axis.title.x=element_text(family="sans",face="italic",size=18,vjust=0.5,hjust=0.5,
                              color="black",angle=0),
    axis.title.y=element_text(family="sans",face="italic",size=18,vjust=0.5,hjust=0.5,
                              color="black",angle=0),
    axis.text.x=element_text(family="mono",face="italic",size=14,vjust=0.5,hjust=0.5,
                             color="black",angle=0),
    axis.text.y=element_text(family="mono",face="italic",size=14,vjust=0.5,hjust=0.5,
                             color="black",angle=0),
    panel.background=element_rect(fill="gray92"),
    panel.grid.major=element_line(color="white",size=1),
    panel.grid.minor=element_line(color="white",size=0.5)
  )

## Ejemplo 3 
mitema <-theme(
  plot.title=element_text(family="sans",face="italic",size=20,vjust=0.5,hjust=0.5,
                          color="blue",angle=0),
  axis.title.x=element_text(family="sans",face="italic",size=18,vjust=0.5,hjust=0.5,
                            color="black",angle=0),
  axis.title.y=element_text(family="sans",face="italic",size=18,vjust=0.5,hjust=0.5,
                            color="black",angle=90),
  axis.text.x=element_text(family="mono",face="italic",size=14,vjust=0.5,hjust=0.5,
                           color="black",angle=0),
  axis.text.y=element_text(family="mono",face="italic",size=14,vjust=0.5,hjust=0.5,
                           color="black",angle=0),
  panel.background=element_rect(fill="black"),
  panel.grid.major=element_line(color="gray92",size=0.2),
  panel.grid.minor=element_line(color="gray92",size=0.2)
)


## Ejemplo 4 
ggplot(advertising,aes(x=TV,y=sales)) +
  geom_point(color="green",shape=16,size=2) +
  geom_smooth(method="lm",formula=y ~ poly(x,degree=10),se=FALSE,size=1,
              linetype="solid",color="white") + 
  labs(title="Ventas versus inversión en publicidad en TV",x="Publicidad en TV",y="Ventas") + 
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) + mitema
  
##Ejemplo 5 
ggplot(advertising,aes(x=TV,y=sales)) +
  geom_point(color="green",shape=16,size=2) +
  geom_smooth(method="gam",formula=y ~ s(x,bs="cr"),se=FALSE,size=1,
              linetype="solid",color="white") + 
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  labs(title="Ventas versus inversión en publicidad en TV",x="Publicidad en TV",y="Ventas") + mitema
##Ejemplo 6 
ggplot(advertising,aes(x=TV,y=sales,size=radio)) +
  geom_point(color="red",shape=16) +
  labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",size="Publicidad\n en radio") +
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  scale_size(range=c(0,5)) + mitema +
  theme(legend.position="right",
        legend.title=element_text(face="bold",size=15,hjust=0.5,vjust=0.5,
                                  color="black",angle=0),
        legend.text=element_text(face="plain",size=13,hjust=0.0,vjust=0.5,
                                 color="black",angle=0),
        legend.direction="vertical"
  )
##Ejemplo 7 
mitema <- mitema + 
  theme(legend.position="right",
        legend.title=element_text(family="sans",face="italic",size=15,hjust=0.5,vjust=0.5,
                                  color="black",angle=0),
        legend.text=element_text(family="sans",face="plain",size=13,hjust=0.0,vjust=0.5,
                                 color="black",angle=0),
        legend.direction="vertical"
  )
##Ejemplo 8 
ggplot(advertising,aes(x=TV,y=sales,color=radio)) +
  geom_point(size=4,shape=16) +
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",color="Publicidad\n en radio") +
  scale_color_gradient(low="blue",high="red",breaks=seq(0,50,10)) + mitema

##Ejemplo 9 
help(cut_number)

names <- c("Baja","Media","Alta")
advertising <- within(advertising,radioC <- cut_number(radio,n=3,labels=names))
with(advertising,table(radioC))

ggplot(advertising,aes(x=TV,y=sales,color=radioC,shape=radioC)) +
geom_point(size=3.5) +
labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",color="Publicidad\n en radio",shape="Publicidad\n en radio") +
scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
scale_color_manual(values=c("blue","black","red")) +
scale_shape_manual(values=c(15,16,17)) + mitema

##Ejemplo 10 
ggplot(advertising,aes(x=TV,y=sales,color=radioC,shape=radioC)) +
  geom_point(size=3.5) +
  geom_smooth(method="lm",formula=y ~ poly(x,degree=3),se=FALSE,size=1,linetype="solid") +
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",color="Publicidad\n en radio",shape="Publicidad\n en radio") +
  scale_color_manual(values=c("blue","black","red")) +
  scale_shape_manual(values=c(15,16,17)) + mitema

##Ejemplo 11 
ggplot(advertising,aes(x=TV,y=sales,color=radioC,shape=radioC)) +
  geom_point(size=3.5) +
  geom_smooth(method="gam",formula=y ~ s(x,bs="cr"),se=FALSE,size=1,linetype="solid") + 
  scale_x_continuous(breaks=seq(from=0,to=300,by=50)) +
  scale_y_continuous(breaks=seq(from=0,to=30,by=5)) +
  labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",color="Publicidad\n en radio",shape="Publicidad\n en radio") +
  scale_color_manual(values=c("blue","black","red")) +
  scale_shape_manual(values=c(15,16,17)) + mitema

##Ejemplo 12 
names <- c("Baja","Media baja","Media alta","Alta")
advertising <- within(advertising,newspaperC <- cut_number(newspaper,n=4,labels=names))
with(advertising,table(newspaperC))

ggplot(advertising,aes(x=TV,y=sales,color=radioC)) +
  geom_point(size=3.5,shape=16) +
  geom_smooth(method="lm",formula=y ~ poly(x,degree=3),se=FALSE,size=1,linetype="solid") + 
  labs(title="Ventas versus inversión en publicidad para TV",x="Publicidad para TV",
       y="Ventas",subtitle="Publicidad en periodico",color="Publicidad\n en radio") +
  scale_color_manual(values=c("blue","black","red")) +
  facet_wrap(vars(newspaperC),ncol=2,nrow=2,strip.position="top",dir="h",scales="free") + mitema + 
  theme(
    plot.subtitle=element_text(face="bold",size=16,vjust=0.5,hjust=0.5,color="salmon"),
    strip.background=element_rect(color="black",fill="gray80",size=1),
    strip.text=element_text(face="bold",size=13,vjust=0.5,hjust=0.5,color="black",angle=0)
  )

##Ejemplo 13 
names <- c("Baja","Media baja","Media alta","Alta")
names2 <- c("Baja","Media","Alta")
advertising <- within(advertising,{
  radioC <- cut_number(radio,n=4,labels=names)
  TVC <- cut_number(TV,n=3,labels=names2)
})
with(advertising,table(radioC))
with(advertising,table(TVC))

ggplot(advertising,aes(x=TVC,y=sales,fill=TVC)) +
  geom_boxplot(outlier.shape=NA,color="black",linetype="solid") +
  scale_y_continuous(breaks=seq(from=0,to=25,by=5),limits=c(5,25)) + 
  scale_fill_manual(values=c("red","yellow","blue")) + 
  labs(subtitle="Inversión en publicidad en radio",
       x="Inversión en publicidad en TV", y="Ventas") +
  facet_wrap(vars(radioC),ncol=4,nrow=1,strip.position="top",dir="h",scales="fixed") +
  mitema + 
  theme(
    legend.position="none",
    plot.subtitle=element_text(face="bold",size=18,vjust=0.5,hjust=0.5,color="blue"),
    strip.background=element_rect(color="black",fill="gray80",size=1),
    strip.text=element_text(face="bold",size=15,vjust=0.5,hjust=0.5,color="black",angle=0)
  )

##Ejemplo 14 
install.packages("readr")
library(readr)
spruce <- read_delim("spruce.txt",delim="\t",col_names=TRUE)
spruce <- within(spruce,treat <- factor(treat,labels=c("normal","enriquecida\n con ozono")))
str(spruce)

ggplot(spruce,aes(x=factor(days),y=size/1000,fill=treat)) + 
  geom_boxplot(outlier.shape=NA,color="black",linetype="solid") + 
  scale_y_continuous(breaks=seq(from=0,to=150,by=25),limits=c(0,150)) + 
  labs(x="Días desde el comienzo del experimento", y="Tamaño", fill="Atmósfera") + 
  scale_fill_manual(values=c("salmon2","green2")) + 
  mitema + theme(legend.position="right",
                 legend.text=element_text(size=14,hjust=0),
                 legend.title=element_text(face="bold",size=15))

##Ejemplo 15 
Pobl <- Municipios %>% 
  group_by(Region) %>% 
  summarise(freq=sum(Poblacion)) %>% 
  mutate(percent=round(100*freq/sum(freq),digits=1),
         labels=paste0(str_replace(Region,"Región ",""),"\n (",percent,"%)"))

ggplot(Pobl,aes(x="",y=freq,fill=Region)) +
  geom_col(color="black",linetype="solid") +
  geom_text(aes(label=labels),position=position_stack(vjust=0.5),size=5.2,fontface="bold") +
  coord_polar(theta="y") +
  labs(title="Distribución de la Población por Región") + 
  scale_fill_brewer(palette="RdBu") + 
  theme(axis.text = element_blank(),axis.ticks = element_blank(),
        axis.title = element_blank(),panel.grid = element_blank(),
        panel.background=element_rect(fill="gray92"),legend.position="none",
        plot.title=element_text(family="sans",face="bold",size=22,
                                vjust=0.5,hjust=0.5,color="black"))

##Ejemplo 16 

Supe <- Municipios %>% 
  group_by(Region) %>% 
  summarise(freq=sum(Superficie)) %>% 
  mutate(percent=round(100*freq/sum(freq),digits=1),
         labels=paste0(str_replace(Region,"Región ",""),"\n (",percent,"%)"))

ggplot(Pobl,aes(x="",y=freq,fill=Region)) +
  geom_col(color="black",linetype="solid") +
  geom_text(aes(label=labels),position=position_stack(vjust=0.5),size=5.2,fontface="bold") +
  coord_polar(theta="y") +
  labs(title="Distribución de la Superficie por Región") + 
  scale_fill_brewer(palette="RdBu") + 
  theme(axis.text = element_blank(),axis.ticks = element_blank(),
        axis.title = element_blank(),panel.grid = element_blank(),
        panel.background=element_rect(fill="gray92"),legend.position="none",
        plot.title=element_text(family="sans",face="bold",size=22,
                                vjust=0.5,hjust=0.5,color="black"))

##Ejemplo 17 
Pobl2 <- Municipios %>% 
  group_by(Region,Zona) %>% 
  summarise(freq2=sum(Poblacion)) %>%
  inner_join(Pobl,by=c("Region"="Region")) %>%
  mutate(percent=round(100*freq2/freq,digits=1),
         labels=paste0(Zona,"\n (",percent,"%)"))

ggplot(Pobl2,aes(x="",y=percent,fill=Zona)) +
  geom_col(color="black",linetype="solid") +
  geom_text(aes(label=labels),position=position_stack(vjust=0.5),size=5.2,fontface="bold") +
  coord_polar(theta="y") +
  labs(title="Distribución de la Población por Zona") + 
  scale_fill_brewer(palette="RdBu") + 
  facet_wrap(vars(Region),ncol=3,nrow=2,strip.position="top",dir="h") + 
  theme(axis.text = element_blank(),axis.ticks = element_blank(),
        axis.title = element_blank(),panel.grid = element_blank(),
        plot.title=element_text(family="sans",face="bold",size=22,vjust=0.5,hjust=0.5,color="black"),
        strip.background=element_rect(color="black",fill="gray80",size=1),
        strip.text=element_text(face="bold",size=15,vjust=0.5,hjust=0.5,color="blue",angle=0),
        panel.background=element_rect(fill="gray92"),legend.position="none")

##Ejemplo 18 
ggplot(Municipios, aes(Region)) + 
  geom_bar(aes(fill=Zona),position=position_dodge(),width=0.75) + 
  scale_y_continuous(breaks=seq(from=0,to=300,by=50)) + 
  scale_fill_manual(values=c("yellow","blue")) + 
  labs(title="Número de municipios por región", x=" ", y="Número de Municipios") + 
  coord_flip() + 
  mitema + theme(legend.position="right",
                 axis.text.y=element_text(size=18,hjust=1),
                 axis.title.x=element_text(color="red"))

##Ejejmplo 19

ggplot(Municipios, aes(Region)) + 
  geom_bar(aes(fill=Zona,weight=Superficie/1000),position=position_dodge(),width=0.75) + 
  scale_y_continuous(breaks=seq(from=0,to=500,by=100)) + 
  scale_fill_manual(values=c("yellow","blue")) + 
  labs(title="Superficie por región", x=" ", y="Superficie, en miles de kilómetros cuadrados") + 
  coord_flip() + 
  mitema + theme(legend.position="right",
                 axis.text.y=element_text(size=18,hjust=1),
                 axis.title.x=element_text(color="red"))

##Ejemplo 20 

ggplot(Municipios, aes(Region)) + 
  geom_bar(aes(fill=Zona,weight=Poblacion/1000),position=position_dodge(),width=0.75) + 
  scale_y_continuous(breaks=seq(from=0,to=12500,by=2500)) + 
  scale_fill_manual(values=c("yellow","blue")) + 
  labs(title="Población por región", x=" ", y="Población, en miles") + 
  coord_flip() + 
  mitema + theme(legend.position="right",
                 axis.text.y=element_text(size=18,hjust=1),
                 axis.title.x=element_text(color="red"))
##Ejemplo 20.1

ggplot(Municipios, aes(Region)) + 
  geom_bar(aes(fill=Zona,weight=Poblacion/1000),position=position_dodge(),width=0.75) + 
  scale_y_continuous(breaks=seq(from=0,to=12500,by=2500)) + 
  scale_fill_manual(values=c("yellow","blue")) + 
  labs(title="Población por región", x=" ", y="Población, en miles") + 
  mitema + theme(legend.position="right",
                 axis.text.y=element_text(size=18,hjust=1),
                 axis.title.x=element_text(color="red"))
##Ejemplo 20.2

ggplot(Municipios, aes(Region)) + 
  geom_bar(aes(fill=,weight=Poblacion/1000),position=position_dodge(),width=0.75) + 
  scale_y_continuous(breaks=seq(from=0,to=12500,by=2500)) + 
  scale_fill_manual(values=c("yellow","blue")) + 
  labs(title="Población por región", x=" ", y="Población, en miles") + 
  coord_flip() + 
  mitema + theme(legend.position="right",
                 axis.text.y=element_text(size=18,hjust=1),
                 axis.title.x=element_text(color="red"))


##Ejemplo 21 
ggplot(Municipios, aes(Zona)) + 
  geom_bar(aes(fill=Zona,weight=Poblacion/1000),position=position_dodge(),width=0.8,color="black") + 
  scale_y_continuous(breaks=seq(from=0,to=12500,by=2500)) + 
  scale_fill_manual(values=c("green","green")) + 
  labs(title="Población por región", x=" ", y="Población, en miles") + 
  facet_wrap(vars(Region),ncol=3,nrow=2,strip.position="top",dir="h",scales="fixed") + mitema + 
  theme(
    plot.subtitle=element_text(face="bold",size=16,vjust=0.5,hjust=0.5,color="salmon"),
    strip.background=element_rect(color="black",fill="gray80",size=1),
    strip.text=element_text(face="bold",size=15,vjust=0.5,hjust=0.5,color="black",angle=0),
    axis.title.y=element_text(color="black")  
  )

##Ejemplo 22 
install.packages("sf")

library(dplyr)
library(readr)

deptos <- Municipios %>%
  group_by(Departamento,Dep) %>%
  summarise(Irural=sum(Poblacion*Irural)/sum(Poblacion)) %>%
  as.data.frame()
str(deptos)

deptoshp <- sf::st_read("MGN_DPTO_POLITICO.shp",quiet=TRUE)
str(deptoshp)

mapdeptos <- deptoshp %>% left_join(deptos,by=c("DPTO_CCDGO"="Dep"))
str(mapdeptos)

mundoshp <- sf::st_read("admin00.shp",quiet=TRUE)
mundocol <- mundoshp %>% 
  filter(CNTRY_NAME %in% c("Peru","Brazil","Venezuela","Ecuador","Panama"))
str(mundocol)

ggplot() +
  geom_sf(data=mundocol) +#fill diferente a col donde col es linea.
  geom_sf(data=mapdeptos,aes(fill=Irural),col="darkgray",linetype="solid") +
  coord_sf(xlim=c(-79.5,-66.5),ylim=c(-4.5,13),expand=FALSE) +
  geom_sf_text(data=mapdeptos,aes(label=ifelse(Irural > 70,Departamento,"")),col="black",
               fontface="bold",size=4,fun.geometry=function(x) sf::st_centroid(x)) +
  labs(x="Longitud",y="Latitud",title="Colombia",fill="Índice de\nRuralidad") +
  scale_fill_gradient(low="white",high="purple",n.breaks=5) +
  annotate("text", x=c(-74.5,-68,-78,-69,-78.5), y=c(-2.5,0,-1,9,9), colour="blue",
           label=c("Perú","Brasil","Ecuador","Venezuela","Panamá")) +
  theme(panel.background=element_rect(fill="lightblue"))
Municipios
##Ejemplo 23

mpioshp <- sf::st_read("MGN_MPIO_POLITICO.shp",quiet=TRUE)
str(mpioshp)

Municipios<-read_rds("Municipios.RDS")

cund <- mpioshp %>%
  left_join(Municipios,by=c("MPIO_CCNCT"="Depmun")) %>%
  filter(DPTO_CCDGO=="25" | DPTO_CCDGO=="11")
str(cund)


ggplot() +
  geom_sf(data=deptoshp) +
  geom_sf(data=cund,aes(fill=Irural),col="darkgray",linetype="solid") +
  geom_sf_text(data=cund,aes(label=ifelse(Irural > 52,Municipio,"")),col="black",
               fontface="bold",size=3.5,fun.geometry=function(x) sf::st_centroid(x)) +
  labs(x="Longitud",y="Latitud",title="Cundinamarca",fill="Índice de\nRuralidad") +
  coord_sf(xlim=c(-74.9,-73.0),ylim=c(3.7,5.8)) + 
  scale_fill_gradient(low="white",high="red",n.breaks=5)


##Ejemplo 24 

mpioshp <- sf::st_read("MGN_MPIO_POLITICO.shp",quiet=TRUE)
str(mpioshp)

Municipios<-read_rds("Municipios.RDS")

andi <- mpioshp %>%
  left_join(Municipios,by=c("MPIO_CCNCT"="Depmun")) %>%
  filter(DPTO_CCDGO=="05")
str(andi)


ggplot() +
  geom_sf(data=deptoshp) +
  geom_sf(data=andi,aes(fill=Irural),col="darkgray",linetype="solid") +
  geom_sf_text(data=cund,aes(label=ifelse(Irural > 52,Municipio,"")),col="black",
               fontface="bold",size=3.5,fun.geometry=function(x) sf::st_centroid(x)) +
  labs(x="Longitud",y="Latitud",title="Antioquia",fill="Índice de\nRuralidad") +
  coord_sf(xlim=c(-77,-74.5),ylim=c(8.8,5.5)) + 
  scale_fill_gradient(low="white",high="red",n.breaks=5)



##Probablidad

## binom
size <- 10
mus <- c(0.1,0.2,0.4,0.6,0.8,0.9)
binom <- expand.grid(mu=mus,x=seq(0,1,1/size))

binom <- within(binom,{prob <- dbinom(x=size*x,size=size,prob=mu)
cdf <- pbinom(q=size*x,size=size,prob=mu)
mu <- factor(mu,labels=paste("mu==",mus))})

str(binom)

ggplot(binom) + 
  geom_segment(aes(x=x,xend=x,y=0,yend=prob),col="red",size=1.25) + 
  labs(x="y",y=bquote(~f[Y]~"(y;m,"~mu~")")) + 
  facet_wrap(vars(mu),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

dev.new()	   

ggplot(binom) + 
  geom_segment(aes(x=x,xend=x+0.1,y=cdf,yend=cdf),col="green",size=1.25) + 
  labs(x="y",y=bquote(~F[Y]~"(y;m,"~mu~")")) + 
  facet_wrap(vars(mu),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

#pois
rango <- c(0,8)
mus <- seq(from=1,to=3.5,by=0.5)
pois <- expand.grid(mu=mus,x=seq(from=rango[1],to=rango[2],by=1))
pois <- within(pois,{prob <- dpois(x,lambda=mu)
cdf <- ppois(x,lambda=mu)
mu <- factor(mu,labels=paste("mu==",mus))})

ggplot(pois) + 
  geom_segment(aes(x=x,xend=x,y=0,yend=prob),col="red",size=1.25) + 
  labs(x="y",y=bquote(~f[Y]~"(y;"~mu~")")) + 
  facet_wrap(vars(mu),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

dev.new()	   
ggplot(pois) + 
  geom_segment(aes(x=x,xend=x+1,y=cdf,yend=cdf),col="red",size=1.25) + 
  labs(x="y",y=bquote(~F[Y]~"(y;"~mu~")")) + 
  facet_wrap(vars(mu),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

##Normal
mu <- 0
phis <- c(0.1,0.2,0.3,0.6,0.9,1.2)
x <- seq(from=-4,to=4,length=200)
norms <- expand.grid(mu=mu,phi=phis,x=x)
norms <- within(norms,{pdf <- dnorm(x=x,mean=mu,sd=sqrt(phi))
cdf <- pnorm(q=x,mean=mu,sd=sqrt(phi))
phi <- factor(phi,labels=paste("phi==",phis))})

ggplot(norms) + 
  geom_line(aes(x=x,y=pdf),col="red",size=1.1) + 
  labs(x="y",y=bquote(~f[Y]~"(y;"~mu~","~phi~")")) + 
  facet_wrap(vars(phi),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

dev.new()	   
ggplot(norms) + 
  geom_line(aes(x=x,y=cdf),col="red",size=1.1) + 
  labs(x="y",y=bquote(~F[Y]~"(y;"~mu~","~phi~")")) + 
  facet_wrap(vars(phi),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

##Gama
mu <- 1
phis <- c(0.08,0.15,0.35,0.65,0.9,1.2)
x <- seq(from=0.01,to=2.5,length=200)
gama <- expand.grid(mu=mu,phi=phis,x=x)
gama <- within(gama,{pdf <- dgamma(x=x,shape=1/phi,scale=mu*phi)
cdf <- pgamma(q=x,shape=1/phi,scale=mu*phi)
phi <- factor(phi,labels=paste("phi==",phis))})

ggplot(gama) + 
  geom_line(aes(x=x,y=pdf),col="red",size=1.1) + 
  labs(x="y",y=bquote(~f[Y]~"(y;"~mu~","~phi~")")) + 
  facet_wrap(vars(phi),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

dev.new()	   
ggplot(gama) + 
  geom_line(aes(x=x,y=cdf),col="red",size=1.1) + 
  labs(x="y",y=bquote(~F[Y]~"(y;"~mu~","~phi~")")) + 
  facet_wrap(vars(phi),nrow=2,scale="free_x",labeller=label_parsed) +
  mitema

##
install.packages("words")
library(words)

?sample
str(words)

hangman <- function(longitud=8, dificultad=c("bajo","normal","alto")){
  dificultad=match.arg(dificultad)
  dict <- subset(words,word_length >= longitud)
  s <- sample(1:nrow(dict),size=1,prob = dict[,2])
  word <- dict[s,1]
  n <- nchar(word)
  wordv <- vector()
  for(i in 1:n) wordv[i] <- substr(word,i,i)
  estado <- matrix("__",n,1)
  usadas <- vector()
  if (dificultad=="bajo")(intentos<-ceiling(length(unique(wordv))*2.5))
  if (dificultad=="medio")(intentos<-ceiling(length(unique(wordv))*1.5))
  if (dificultad=="alto")(intentos<-ceiling(length(unique(wordv))*0.5))
  vez <- 1
  cat("Bienvenido al juego del ahorcado!!!\n\n",sep="")
  cat("Adivina la palabra de ",n," letras en inglés. Tienes ",intentos," intentos.\n\n",sep="")
  while(vez <= intentos & sum(estado=="__")>=1){
    intento <- tolower(readline("Digita una letra\n"))
    if(intento %in% letters){
      ids <- wordv==intento
      if(match(intento,usadas,nomatch=0) == 0){
        cat("Intento ",vez,". Te quedan ",intentos-vez,".\n",sep="")
        if(any(ids)){
          cat("Bien...\n",sep="")
          estado[ids] <- intento
          cat(paste(estado,collapse=" "),"\n",sep="")
        }else{
          cat("Lo siento. La letra ",toupper(intento)," no hace parte de la palabra oculta.\n",sep="")
          cat(paste(estado,collapse=" "),"\n",sep="")
        }
        usadas <- c(usadas,intento)
        vez <- vez + 1
      }if(dificultad !="alto"){
        cat("Ya habias intentado con la letra ",toupper(intento),".\n",sep="")
        cat(paste(estado,collapse=" "),"\n",sep="")
      }
      if(dificultad=="alto"){
        cat("Lo siento. La letra ",toupper(intento)," no hace parte de la palabra oculta.\n",sep="")
        cat(paste(estado,collapse=" "),"\n",sep="")
      }
      usadas <- c(usadas,intento)
      vez <- vez + 1}
    }else cat("La letra que digitaste no hace parte del alfabeto inglés.\n",sep="")
  }
  if(sum(estado=="__")==0) cat("Felicitaciones. Ganaste!!!!\n",sep="")
  if(vez > intentos){
    cat("Lo lamento. Perdiste!!!!\n",sep="")
    cat("La palabra oculta es ",toupper(word),"\n",sep="")
  }  
}
hangman(9,"alto")

## Funciones en R

#saludo<- function(nombre){
#  nombre <-readline("¿Cual es tu nombre? ")
#  if (nombre== NULL)
    
    
 # cat("Hola", nombre, "¿como estas?")
  
  
  
#}
#saludo()


primos <- function(n){
  if(missingArg(n)) stop("ponga algo ",call.=FALSE)
  if(!is.numeric(n)) stop("ponga un NUMERO",call.=FALSE)
  if(n<=1) stop("Ponga un numero mayor que uno ",call.=FALSE)
  if(n!=floor(n)) {
    n<-round(n,0)
    warning("No es un entero, lo redondeamos", call.=FALSE)}
  nmax <- max(2,floor(sqrt(n)))
  out <- matrix(0,nrow=nmax,ncol=1)
  m <- n
  id <- 1
  for(i in 2:nmax){
    while(m%%i == 0){
      out[id] <- i
      m <- m/i
      id <- id + 1
    }
  }
  out <- c(out,m); out <- out[out > 1]
  salida <- list(primo=c(out[1]==n),factores=out)
  if(salida$primo) 
    cat("\n",n,"es un número primo")
  else{
    cat("\n",n,"no es un número primo.\n De hecho, ")
    f <- table(salida$factores)
    f2 <- ifelse(f > 1,paste0(rownames(f),"^(",f,")"),rownames(f))
    cat(n,"=",paste0(f2,collapse=" * "),"\n")
  }
  return(invisible(salida))
}

y<-primos(2050)

cumprod(y$factores)
## el 37 es el 12abo numero primo y el 73 es el 21abo numero primo 
#y se demostro que son los unicos numero que se sabe que cumplen esa propiedad 

#Ejemplo 2
summ <- function(x){
  x2 <- na.omit(x)
  y <- c(quantile(x2,c(0,0.25,0.5,0.75,1)),length(boxplot.stats(x2)$out),sum(is.na(x)))
  y <- c(y[1:6],100*y[6]/length(x),y[7],100*y[7]/length(x))
  names(y) <- c("Min","Q1","Median","Q3","Max","Outliers","(%)Outliers","Missings","(%)Missings")
  return(round(y,digits=2))
}

summ2 <- function(x){
  x2 <- na.omit(x)   
  y <- c(length(unique(x2)),sum(is.na(x)))
  y <- c(y,100*y[2]/length(x))
  names(y) <- c("Levels","Missings","(%)Missings")
  return(round(y,digits=2))
}

eda <- function(datos,tipo=c("ambos","num","text"), verbose=TRUE){
  tipo=match.arg(tipo) # si dijita algo diferente lo saca, tima el primero por omision
  clases <- sapply(datos,class)
  num <- clases == "numeric" | clases == "integer"
  text <- clases == "character" | clases == "factor"
  out_ <- list()
  if(any(num) & tipo!="text"){
    cat("\n***Resumen de las variables numéricas***\n\n")
    datos1 <- as.data.frame(datos[,num])
    colnames(datos1) <- colnames(datos)[num]
    out_$numeric <- apply(datos1,2,summ)
    if (verbose==TRUE)
    (print(out_$numeric))
  }
  if(any(text) & tipo!="num"){
    cat("\n***Resumen de las variables de texto***\n\n")
    datos2 <- as.data.frame(datos[,text])
    colnames(datos2) <- colnames(datos)[text]
    out_$text <- apply(datos2,2,summ2)  
    if (verbose==TRUE)
    (print(out_$text))
  }
  missings <- apply(datos,1,function(x) return(sum(is.na(x))))
  if(any(missings > 0)){
    cat("\n***Número de missings por individuo***\n\n")
    miss <- as.matrix(table(missings))
    miss <- cbind(miss,round(100*miss/sum(miss),digits=2))
    colnames(miss) <- c("Frequency","%")
    out_$missings <- miss 
    if (verbose==TRUE)(
    print(miss))
  }
  return(invisible(out_))                  
}

eda(airquality,"text",FALSE)
eda(USArrests,"cosa")
eda(Municipios,"ambos")
y<-eda(airquality)
y
class(y)
summary.default(y)



clases <- sapply(USArrests,class)
clases
num <- clases == "numeric" | clases == "integer"
text <- clases == "character" | clases == "factor"
num
text
