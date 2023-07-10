## parcial 1 
#librerias
library(readxl)
library(readr)
library(stringr)
library(sqldf)
library(dplyr)
library(ggplot2)
source("mismacros.txt")

# datos 
ofrecidos <- read_excel("ofrecidos.xlsx")
str(ofrecidos)
cursos <- read_delim("cursos.txt",delim=";")
str(cursos)
docentes <- read_delim("docentes.csv",delim=",")
str(docentes)

#ofresidos con nombre del curso 
ofrecidosc <- ofrecidos%>%
  left_join(cursos, by =c("CodigoCurso" = "CodigoCurso"))%>%
  as.data.frame()

str(ofrecidosc)

ofrecidosd <- ofrecidos%>%
  left_join( docentes, by=c("IdDocente" = "IdDocente"))%>%
  as.data.frame()

str(ofrecidosd)
### A
#En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo más cupos de
#“Probabilidad y Estadística Fundamental”?

ofrecidosc %>%
  filter(NombreCurso=="Probabilidad y Estadística Fundamental") %>%
  group_by(Semestre) %>%
  summarise(ngrupos=n()) %>%
  arrange(desc(ngrupos)) %>% 
  as.data.frame()


##B
#En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo más grupos de
#“Bioestadística Fundamental”?

ofrecidosc %>%
  filter(NombreCurso=="Bioestadística Fundamental") %>%
  group_by(Semestre) %>%
  summarise(ngrupos=n()) %>%
  arrange(desc(ngrupos)) %>% 
  as.data.frame()
##C
#En cual semestre del periodo comprendido entre 2014-I y 2016-II hubo mayor 
#homoge-neidad (de acuerdo al coeficiente de variación) entre los grupos de 
#“Estadística Social Fundamental” en relación al número de cupos ofrecidos?

ofrecidosc %>%
  filter(NombreCurso=="Estadística Social Fundamental") %>%
  group_by(Semestre) %>%
  summarise(cvcupos=sd(CuposN)/mean(CuposN)) %>%
  arrange(cvcupos) %>% 
  as.data.frame()

## D 
#Cuales cursos del pregrado en Estadística (especifique código y nombre) 
#de la agrupación “Complementación” se ofrecieron solo un semestre en el periodo comprendido
#entre 2014-I y 2016-II?

ofrecidosc%>%
  filter(Agrupacion=="Complementación")%>%
  group_by(NombreCurso, CodigoCurso)%>%
  summarise(curdif=n_distinct(Semestre)) %>%
  filter(curdif==1) %>% 
  select(-curdif) %>% 
  as.data.frame()

## E
#Cuales cursos del pregrado en Estadística (especifique código y nombre) de la 
#agrupación “Nuclueo” se ofrecieron todos los semestres en el periodo comprendido 
#entre 2014-I y 2016-II?

ofrecidosc%>%
  filter(Agrupacion=="Nucleo")%>%
  group_by(NombreCurso, CodigoCurso)%>%
  summarise(curdif=n_distinct(Semestre)) %>%
  filter(curdif==6) %>% 
  select(-curdif) %>% 
  as.data.frame()

## F 
#Cuales profesores(as) (especifique identificador y nombre) dictaron en solo 
#uno de los programas del departamento de Estadística (es decir, Pregrado, 
#Especialización, Maestría y Doctorado) en el periodo comprendido entre 
#2014-I y 2016-II?

ofrecidosd %>%
  filter(!is.na(IdDocente)) %>%
  group_by(IdDocente,NombreDocente) %>%
  summarise(progsdif=n_distinct(Programa)) %>%
  filter(progsdif==1) %>% 
  select(-progsdif) %>% 
  as.data.frame()

## G 
#Cuales profesores(as) (especifique identificador y nombre) dictaron en todos 
#los programas del departamento de Estadística (es decir, Pregrado, 
#Especialización, Maestria y Doctorado) en el periodo comprendido 
#entre 2014-I y 2016-II?

ofrecidosd %>%
  filter(!is.na(IdDocente)) %>%
  group_by(IdDocente,NombreDocente) %>%
  summarise(progsdif=n_distinct(Programa)) %>%
  filter(progsdif==4) %>% 
  select(-progsdif) %>%
  as.data.frame()

## H
#Cual(es) es(son) el(los) profesor(es) con el menor número de asignaturas 
#diferentes en los programas del departamento de Estadística (es decir, 
#Pregrado, Especialización,Maestría y Doctorado) en el periodo de tiempo 
#comprendido entre 2014-I y 2016-II?

ofrecidosd %>%
  filter(!is.na(IdDocente)) %>%
  group_by(IdDocente,NombreDocente) %>%
  summarise(progsdif=n_distinct(Programa)) %>%
  arrange(progsdif)%>%
  as.data.frame()

## I 
#Cuales de las agrupaciones del pregrado en Estadística (nombre) han tenido 
#número de cursos y número de cupos mayores al 35 % del total que se ofrecieron
#en todos los semestres comprendidos entre 2014-I y 2016-II?

mytable( ~ Agrupacion*Semestre, data=ofrecidosd, ord="freq",
         percent=FALSE, rowperc=FALSE, subset=c(Programa=="Pregrado"))
(54.00/119.00)*100
(26.00/119.00)*100
mytable(CuposN ~ Agrupacion*Semestre, data=ofrecidos3, ord="freq",
        percent=FALSE, rowperc=FALSE, subset=c(Programa=="Pregrado"))
(2368.00/5036.00)*100
(1200.00/5036.00)*100

##J
#En cual de los semestres comprendidos entre 2014-I y 2016-II se tuvo el mayor 
#porcentaje de cupos ofrecidos en cursos con clases los lunes (y por lo tanto 
#perjudicadospor los feriados) del total de cupos ofrecidos en los programas 
#de posgrado (es decir, Especialización, Maestría y Doctorado)?

ofrecidosl<-within(ofrecidosd,Lunes<-ifelse(str_sub(Dia,1,2)=="LU","Si","No"))

mytable(CuposN ~ Lunes*Semestre, data=ofrecidosl, ord="freq",
        percent=FALSE, rowperc=FALSE,
        subset=c(Programa %in% c("Especialización","Maestría","Doctorado")))

(181.00/3769.00)*100
