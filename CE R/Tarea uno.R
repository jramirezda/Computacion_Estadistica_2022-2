#Jhon Alejandro Ramírez Daza 
#Angela Gissel López Rodríguez

#NOTA: Profe no encontramos otro integrante aunque preguntamos a los compañeros, seguimos estando pendientes por si alguien nos contesta.

#17/08/2022
#Tarea 1 Computación Estadistica.
library(readxl)
library(readr)
#English Premier League

#Temporada 2014-2015
tem14_15 <- read_excel("season-1415.xlsx", sheet= "season-1415", skip=1, 
                      col_names=c("Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","Referee","HS","AS","HST","AST","HF","AF","HC","AC","HY","AY","HR","AR"),
                      col_types=c("text","date","text","text","numeric","numeric","skip","skip","skip","skip","text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
str(tem14_15)
#Temporada 2015-2016
tem15_16 <- read_excel("season-1516.xlsx", sheet= "season-1516", skip=1, 
                       col_names=c("Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","Referee","HS","AS","HST","AST","HF","AF","HC","AC","HY","AY","HR","AR"),
                       col_types=c("text","date","text","text","numeric","numeric","skip","skip","skip","skip","text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
str(tem15_16)
#Temporada 2016-2017
tem16_17 <- read_excel("season-1617.xlsx", sheet= "season-1617", skip=1, 
                       col_names=c("Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","Referee","HS","AS","HST","AST","HF","AF","HC","AC","HY","AY","HR","AR"),
                       col_types=c("text","date","text","text","numeric","numeric","skip","skip","skip","skip","text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
str(tem16_17)
#Temporada 2017-2018
tem17_18 <- read_excel("season-1718.xlsx", sheet= "season-1718", skip=1, 
                       col_names=c("Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","Referee","HS","AS","HST","AST","HF","AF","HC","AC","HY","AY","HR","AR"),
                       col_types=c("text","date","text","text","numeric","numeric","skip","skip","skip","skip","text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
str(tem17_18)
#Temporada 2018_2019
tem18_19 <- read_excel("season-1819.xlsx", sheet= "season-1819", skip=1, 
                       col_names=c("Season","Date","HomeTeam","AwayTeam","FTHG","FTAG","Referee","HS","AS","HST","AST","HF","AF","HC","AC","HY","AY","HR","AR"),
                       col_types=c("text","date","text","text","numeric","numeric","skip","skip","skip","skip","text","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
str(tem18_19)

#IMDb (Internet Movie Database)
library(readr)
library(curl)
install.packages("curl")
Tit_bas <- read_delim(file="https://datasets.imdbws.com/title.basics.tsv.gz",
                      delim="\t",
                      n_max=5000,
                      na=c("","NA","\\N"),
                      col_types=cols("?","?","?","?","?","?","?","?","?"))
str(Tit_bas)

Tit_pri <- read_delim(file="https://datasets.imdbws.com/title.principals.tsv.gz",
                      delim="\t",
                      n_max=5000,
                      na=c("","NA","\\N"),
                      col_types=cols("?","-","?","?","?","?"))
str(Tit_pri)

Nom_bas <- read_delim(file="https://datasets.imdbws.com/name.basics.tsv.gz",
                  delim="\t",
                  n_max=5000,
                  na=c("","NA","\\N"),
                  col_types=cols("?","?","?","?","?","-"))
str(Nom_bas)
#####Shows en Netflix
nombres <- c("id","Tipo","Titulo","Director","Cast","Pais",
             "FechaInicio","AnoRealizacion","Clasificacion","Duracion",
             "Segmentos","Descripcion")

netflix <- read_delim(file="archive.zip",
                      delim=",", skip=1,
                      col_types=cols("c","c","c","c","c","c",col_date("%B %d, %Y"),
                                     "d","c","c","c","c"),
                      col_names=nombres)
str(netflix)