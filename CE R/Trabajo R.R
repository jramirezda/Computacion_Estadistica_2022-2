##Trabajo R Computación estadística
##
## 1 Elecciones presidenciales en Estados Unidos
library(readxl)
library(rlang)
library(lifecycle)
library(sqldf)
library(stringr)
library(dplyr)
library(readr)
missings <- function(x) return(sum(is.na(x)))
elecciones<-read_excel( "elections.xlsx", col_names = TRUE)
str(elecciones)
#15563 regustros con 5 variables donde codecounty es de tipo caracter
condados<-read_excel("counties.xlsx", col_names = TRUE)
str(condados)
#3234 reguistros con 5 variables las primeras tres de tipo caracter y las ultimas dos numericas
estados<-read_excel("states.xlsx",col_names = TRUE)
str(estados)

#56 reguistros con 3 variables las tres de tipo caracter
apply(elecciones,2,missings)
# 0 datos faltantes
apply(condados,2,missings)
#2 datos faltantes en la variable popularidad.
apply(estados,2,missings)
#o datos faltantes

#Verifique que codecounty y codestate son en realidad identificadores de los condados y los estados
#en los conjuntos de datos counties y states, respectivamente.

sqldf("select codecounty
      from condados
      group by codecounty
      having count(*) > 1")

sqldf("select codestate 
      from estados
      group by codestate
      having count(*) > 1")

condados %>%
group_by(codecounty) %>%
summarise(veces=n())%>%
filter(veces>1)

  
estados %>%
group_by(codestate) %>%
summarise(veces=n()) %>%
filter(veces>1)

#Con lo que comprobamos que son unicos y en consecuencia son identificadores.

## limpieza de los datos

condados <- within(condados,{
  county <- str_to_lower(county)
  county <- str_replace_all(county,"[^a-záéíóúüñ ]","")
  county <- str_squish(county)
  county <- str_to_title(county)
})

estados <- within(estados,{
  state <- str_to_lower(state)
  state <- str_replace_all(state,"[^a-záéíóúüñ ]","")
  state <- str_squish(state)
  state <- str_to_title(state)
})

estados <- within(estados,{
  region <- str_to_lower(region)
  region <- str_replace_all(region,"[^a-záéíóúüñ ]","")
  region <- str_squish(region)
  region <- str_to_title(region)
})

head(estados,20)
head(condados,20)

## 6 usaremos los dos metodos tanto sqldf dplyr y system.time()
# SQLDF 
system.time({
Rangossql <- sqldf("select codestate, lower_quartile(population) as p25, 
                upper_quartile(population) as p75
                from condados
                group by codestate 
                having count(*)>= 3")

condadossql<- sqldf("select condados.*, case when population <= p25 then 'low'
                  when population > p75 then 'high'
                  when p25 is null or p75 is null then '' 
                  else 'mid' 
                  end as populationC
                  from condados left join Rangossql on (condados.codestate = Rangossql.codestate)")
})
head(condadossql)


#DPLYR
system.time({
Rangossplyr<- condados %>%
              group_by(codestate) %>%
              summarise(ncondados=n(), p25= quantile(population, 0.25,na.rm = TRUE, type = 2),p75=quantile(population,0.75,na.rm = TRUE, type = 2)) %>%
              filter(ncondados>=3)

condadossplyr<- condados %>%
                left_join(Rangossplyr,by="codestate") %>%
                mutate(populationC= case_when(population <=p25~ "low",
                                              population > p75 ~ "high",
                                              is.na(p25)&is.na(p75)~"",
                                              TRUE ~ "mid"))%>%
                select(everything(condados),populationC) %>% as.data.frame()
})

## 7 Existen dos o más condados con el mismo nombre? Cuantos? Cuales? En qué estados están localizados? Cuales 
#son los tres estados con la mayor densidad poblacional? Cuales son las dos regiones con mayor densidad poblacional?
## primero creamos una tablas utiles
conesta<-sqldf("select condados.*, state,region
                 from condados left join estados on (condados.codestate = estados.codestate)")

elecond<-sqldf("select elecciones.*, county, codestate
               from elecciones left join condados on (elecciones.codecounty = condados.codecounty)")

elestad<-sqldf("select elecond.*, state, region
               from elecond left join estados on (elecond.codestate =estados.codestate )")
 
system.time({
repetidossql <- sqldf("select county 
                      from condados 
                      group by county
                      having count(*)>1")

solsql<- sqldf("select county, codecounty,state,codestate,region
               from conesta 
               where county in (select county from repetidossql)
               order by county, codecounty, state,codestate, region")
})

system.time({
repetidossplyr <-conesta %>% 
  group_by(county) %>%
  summarise(veces=n())%>%
  filter(veces>1)

solsplyr<-conesta %>%
  filter(county %in% repetidossplyr$county) %>%
  arrange(county,codecounty,state,codestate,region) %>%
  select(county,codecounty,state,codestate,region) %>% as.data.frame()
})

all.equal(solsplyr,solsql)
str(solsplyr)

##8 En cuales condados el candidato del partido republicano 
#obtuvo mayor votación que el del partido demócrata en las 
#elecciones presidenciales de 2000, 2004, 2008, 2012 y 2016?

system.time({
repusql<-sqldf("select region, codestate, state, codecounty, county
               from elestad 
               group by region, codestate, state, codecounty, county
               having count(*)=5 and min(republic-democrat)>0")
})

system.time({
repsplyr<- elestad %>%
  group_by(region,codestate,state,codecounty,county)%>%
  summarise(veces=n(),partido=min(republic-democrat)) %>%
  filter(veces==5 & partido >0 )%>% 
  select(-c(veces, partido))%>%
  as.data.frame()
})
all.equal(repsplyr,repusql)


##9 En cuales estados el candidato del partido republicano obtuvo 
#mayor votación que el del partido demócrata en las elecciones presidenciales de 2000 en más del 75%
#del total de condados que los componen?

system.time({
estarepsql<-sqldf("select region, codestate,state
               from elestad
               where year=2000
               group by region, codestate,state
               having lower_quartile(republic-democrat)>0")
})

system.time({
estarepsplyr<- elestad%>%
  filter(year==2000)%>%
  group_by(region,codestate,state)%>%
  summarise(partido=quantile(republic-democrat,0.25,type = 2))%>%
  filter(partido>0)%>%
  select(-partido)%>%
  as.data.frame()
})
all.equal(estarepsql,estarepsplyr)
str(estarepsplyr)

#10 En cuales condados no se tiene niguna información sobre los resultados
#de las votaciones presidenciales realizadas en el periodo comprendido entre los años 2000 y 2016?

system.time({
condanosql<-sqldf("select * 
                  from condados
                  where codecounty not in (select distinct codecounty
                                           from elestad)
                  order by codestate, codecounty, county")
})

system.time({
condanosplyr<- condados %>%
  filter(!(codecounty %in% with(elestad, unique(codecounty))))%>%
  arrange(codestate,codecounty,county)%>%
  as.data.frame()
})

all.equal(condanosplyr,condanosql)
str(condanosplyr)

##11 En cuales condados solo se tiene información sobre algunas, no todas, las votaciones presidenciales
#realizadas en el periodo comprendido entre los años 2000 y 2016?
system.time({
condamesql<-sqldf("select region, codestate,state,codecounty, county, count(*) as veces
                  from elestad 
                  group by region, codestate,state,codecounty,county
                  having veces<5")
})

system.time({
condamesplyr<- elestad%>%
  group_by(region,codestate,state,codecounty,county) %>%
  summarise(veces=n()) %>%
  filter(veces < 5) %>% as.data.frame()
})

all.equal(condamesplyr,condamesql)
str(condamesplyr)

##12 En qué años el candidato demócrata ganó las elecciones en la parte del país formada por 
#los estados con más de 10 millones de habitantes?
system.time({
  conda10sql<-sqldf("select codestate
                from condados
                group by codestate
                having sum(population)>10000000")
 añodemsql<-sqldf("select year 
                  from elestad
                  where codestate in (select codestate from conda10sql)
                  group by year
                  having sum(democrat)>sum(republic) and sum(democrat)>sum(other)")
})

system.time({
conda10splyr<- condados%>%
  group_by(codestate)%>%
  summarise(pop=sum(population))%>%
  filter(pop>10000000)

añodemsplyr<-elestad%>%
  filter(codestate %in% with(conda10splyr, codestate))%>%
  group_by(year)%>%
  summarise(dem=sum(democrat),rep=sum(republic),otros=sum(other))%>%
  filter(dem>rep & dem>otros)%>%
  select(year)%>%
  as.data.frame()
})
all.equal(añodemsplyr,añodemsql)
str(añodemsplyr)

###################################################################################################
#####################################################################################################
#####################################################################################################
#IMDb (Internet Movie Database)

titlebasics <- read_delim(file="titlebasics.tsv",delim="\t")

str(titlebasics)
namebasics <- read_delim(file="namebasics.tsv",delim="\t")
str(namebasics)
titleratings <- read_delim(file="titleratings.tsv",delim="\t")
str(titleratings)
titleprincipals <- read_delim(file="titleprincipals.tsv",delim="\t")
str(titleprincipals)

# 1 Cuantas películas realizadas en la década de los 80 tienen títulos que inician y/o terminan con la palabra "Aliens"?
# cuál tiene mayor duración?
#quien es el director 
#cual es la pelicula mejor calificada del durector
system.time({
aliensql<- sqldf("select * 
                 from titlebasics
                 where (primarytitle like 'Aliens%' or primarytitle like '%Aliens')
                 and startYear <1990 and startYear>=1980")

aliensql<- sqldf("select * 
                 from aliensql
                 order by runtimeMinutes desc
                 limit 1")

direcsql<-sqldf("select tconst
                from titleprincipals
                where category = 'director' and tconst in (select tconst from aliensql)")

direcsql<-sqldf("select *
                from namebasics
                where nconst in (select nconst
				                    from  direcsql)")


mejsql <- sqldf("select titleratings.*
                        from titleratings inner join titleprincipals on (titleratings.tconst=titleprincipals.tconst)
                       where category='director' and nconst in (select nconst
                       from direcsql)
                       order by averageRating desc
                       limit 1")
mejsql <- sqldf("select *
                       from titlebasics
                       where tconst in (select tconst
                       from mejsql)")
mejsql
direcsql
aliensql
})

system.time({
aliensplyr<- titlebasics %>%
filter(str_detect(primaryTitle,"^Aliens|Aliens$") & startYear>=1980 & startYear<1990)%>%  
as.data.frame()  

aliensplyr<- aliensplyr%>%
  arrange(desc(runtimeMinutes))%>%
  filter(row_number()==1)%>%
  as.data.frame()

direcsplyr<- titleprincipals%>%
  filter(tconst==aliensplyr$tconst & category=='director')

direcsplyr<-namebasics%>%
  filter(nconst==direcsplyr$nconst)%>%
  as.data.frame()

Mejsplyr <- titleratings %>%
  inner_join(titleprincipals,by=c("tconst"="tconst")) %>%
  filter(category=="director" & nconst==direcsplyr$nconst)	%>%
  arrange(desc(averageRating)) %>%
  filter(row_number()==1)

Mejsplyr <- titlebasics %>%
  filter(tconst %in% Mejsplyr$tconst) %>% as.data.frame()

Mejsplyr	
direcsplyr
aliensplyr
})


##2 Cuantas películas han sido dirigidas por "Werner Herzog"?
##Cual de ellas tiene la mayor calificación?
#En cuales de ellas participa "Klaus Kinski" como actor? 
#Cuales actores/actrices, además de "Klaus Kinski", participaron en la película titulada "Nosferatu the Vampyre"?

system.time({
wernsql <- sqldf("select *
                       from namebasics
					   where primaryName like '%Werner%Herzog%'")
  
wernsql <- sqldf("select titlebasics.*
                       from titlebasics inner join titleprincipals on (titlebasics.tconst=titleprincipals.tconst)
					   where category='director' and nconst in (select nconst
					                                            from wernsql)") 
wernsql

mejwersql <- sqldf("select wernsql.*, averageRating
                        from wernsql inner join titleratings on (wernsql.tconst=titleratings.tconst)
						order by averageRating desc
						limit 1")
mejwersql

klaussql <- sqldf("select *
                      from namebasics
                     where primaryName like '%Klaus%Kinski%'")

klaussql <- sqldf("select wernsql.*
                     from wernsql inner join titleprincipals on (wernsql.tconst=titleprincipals.tconst)
                     where category='actor' and nconst in (select nconst
                     from klaussql)")
klaussql

nosferatusql <- sqldf("select *
                    from titlebasics
 			        where primaryTitle like '%Nosferatu%the%Vampyre%'")
nosferatusql <- sqldf("select titleprincipals.*, primaryName
                    from titleprincipals inner join namebasics on (titleprincipals.nconst=namebasics.nconst)
 			        where category in ('actor','actress') and tconst in (select tconst
					                                                     from nosferatusql)")
nosferatusql
})

system.time({

Wernsplyr <- namebasics %>%
    filter(str_detect(primaryName,".*Werner.*Herzog.*"))
  
Wernsplyr <- titlebasics %>%
    inner_join(titleprincipals,by=c("tconst"="tconst")) %>%
    filter(nconst==Wernsplyr$nconst & category=="director") %>%
    select(everything(titlebasics)) %>%	as.data.frame()

Wernsplyr

Mejwersplyr <- Wernsplyr %>%
  inner_join(titleratings,by=c("tconst"="tconst")) %>%
  arrange(desc(averageRating)) %>%
  filter(row_number()==1) %>% as.data.frame()

Mejwersplyr

Klaussplyr <- namebasics %>%
  filter(str_detect(primaryName,".*Klaus.*Kinski.*"))

Klaussplyr <- Wernsplyr %>%
  inner_join(titleprincipals,by=c("tconst"="tconst")) %>%
  filter(category=="actor" & nconst==Klaussplyr$nconst) %>%
  select(everything(Wernsplyr)) %>%	as.data.frame()

Klaussplyr

Nosferatusplyr <- titlebasics %>%
  filter(str_detect(primaryTitle,".*Nosferatu.*the.*Vampyre.*"))

Nosferatusplyr <- titleprincipals %>%
  filter(tconst==Nosferatusplyr$tconst & category %in% c("actor","actress")) %>%
  inner_join(namebasics,by=c("nconst"="nconst")) %>% as.data.frame()

Nosferatusplyr
})

##3 Cuantas películas han sido dirigidas por "Martin Scorsese"? 
#Cual de ellas tiene la mayor duración? 
#En cuales de ellas participan "Joe Pesci" y "Robert De Niro" como actores? 
#Cuales actores/actrices, además de "Joe Pesci" y "Robert De Niro", participaron en la película titulada "Raging Bull"?

system.time({
scorsesesql <- sqldf("select *
                         from namebasics
					     where primaryName like '%Martin%Scorsese%'")
  
scorsesesql <- sqldf("select titlebasics.*
                         from titlebasics inner join titleprincipals on (titlebasics.tconst=titleprincipals.tconst)
					     where category='director' and nconst in (select nconst
					                                              from scorsesesql)") 
scorsesesql

largasql <- sqldf("select *
                       from scorsesesql
                       order by runtimeMinutes desc
                       limit 1")
largasql

pescidenirosql <- sqldf("select *
                      from namebasics
				      where primaryName like '%Joe%Pesci%' or primaryName like '%Robert%De%Niro%'")

pescidenirosql <- sqldf("select scorsesesql.tconst, primaryTitle, startYear
                      from scorsesesql inner join titleprincipals on (scorsesesql.tconst=titleprincipals.tconst)
					  where category='actor' and nconst in (select nconst
					                                        from pescidenirosql)
					  group by scorsesesql.tconst, primaryTitle, startYear
					  having count(*) = 2")

pescidenirosql

ragingbullsql <- sqldf("select *
                     from titlebasics
                    where primaryTitle like '%Raging Bull%'")

ragingbullsql <- sqldf("select titleprincipals.*, primaryName
                    from titleprincipals inner join namebasics on (titleprincipals.nconst=namebasics.nconst)
                    where category in ('actor','actress') and tconst in (select tconst
                    from ragingbullsql)")
ragingbullsql
})

system.time({
Scorsesesplyr <- namebasics %>%
    filter(str_detect(primaryName,".*Martin.*Scorsese.*"))
  
Scorsesesplyr <- titlebasics %>%
    inner_join(titleprincipals,by=c("tconst"="tconst")) %>%
    filter(nconst==Scorsesesplyr$nconst & category=="director") %>%
    select(everything(titlebasics)) %>% as.data.frame()

Scorsesesplyr

Largasplyr <- Scorsesesplyr %>%
  arrange(desc(runtimeMinutes)) %>%
  filter(row_number()==1) %>% as.data.frame()

Largasplyr

PesciDeNirosplyr <- namebasics %>%
  filter(str_detect(primaryName,".*Joe.*Pesci.*|.*Robert.*De.*Niro.*"))		

PesciDeNirosplyr <- Scorsesesplyr %>%
  inner_join(titleprincipals,by=c("tconst"="tconst")) %>%
  filter(category=="actor" & nconst %in% PesciDeNirosplyr$nconst) %>%
  select(everything(Scorsesesplyr)) %>%
  group_by(tconst,primaryTitle,startYear) %>%
  summarise(cuantos=n()) %>%
  filter(cuantos==2) %>% select(-c("cuantos")) %>%	as.data.frame()

PesciDeNirosplyr

RagingBullsplyr <- titlebasics %>%
  filter(str_detect(primaryTitle,".*Raging.*Bull.*"))

RagingBullsplyr <- titleprincipals %>%
  filter(tconst==RagingBullsplyr$tconst & category %in% c("actor","actress")) %>%
  inner_join(namebasics,by=c("nconst"="nconst")) %>% as.data.frame()

RagingBullsplyr
})

##4 Cual de las películas realizadas en la década de los 70 tiene la mayor calificación? 
#Quien dirigió esta película? 
#Cual de las películas realizadas en la década de los 90 tiene la mayor calificación? 
#Quienes actuaron en esta película?

system.time({
salidasql <- sqldf("select titlebasics.*, averageRating
                 from titlebasics inner join titleratings on (titlebasics.tconst=titleratings.tconst)")
  
mejor70ssql <- sqldf("select *
                       from salidasql
                       where startYear >= 1970 and startYear <= 1979
                       order by averageRating desc
                       limit 1")
mejor70ssql

directorsql <- sqldf("select *
                    from titleprincipals
					where category='director' and tconst in (select tconst
					                                           from mejor70ssql)") 					   
directorsql <- sqldf("select *
                    from namebasics
					where nconst in (select nconst
					                 from directorsql)")
directorsql

mejor90sql <- sqldf("select *
				   from salidasql
                  where startYear >= 1990 and startYear <= 1999
                  order by averageRating desc
                  limit 1")
mejor90sql

actor90sql <- sqldf("select *
                 from titleprincipals
			     where category in ('actor','actress') and tconst in (select tconst
					                                                  from mejor90sql)") 					   
actor90sql<- sqldf("select *
                 from namebasics
				 where nconst in (select nconst
				                  from actor90sql)")
actor90sql
})


system.time({
Salidasplyr <- titlebasics %>%
    inner_join(titleratings,by=c("tconst"="tconst"))
  
Mejor70splyr <- Salidasplyr %>%
    filter(startYear >= 1970 & startYear <= 1979) %>%
    arrange(desc(averageRating)) %>%
    filter(row_number()==1) %>% as.data.frame()

Mejor70splyr

Directorsplyr <- titleprincipals %>%
  filter(tconst==Mejor70splyr$tconst & category=="director") 

Directorsplyr <- namebasics %>%
  filter(nconst %in% Directorsplyr$nconst) %>% as.data.frame()

Directorsplyr

Mejor90splyr <- Salidasplyr %>%
  filter(startYear >= 1990 & startYear <= 1999) %>%
  arrange(desc(averageRating)) %>%
  filter(row_number()==1) %>% as.data.frame()

Mejor90splyr

Actorsplyr <- titleprincipals %>%
  filter(tconst==Mejor90splyr$tconst & category %in% c("actor","actress")) 	

Actorsplyr <- namebasics %>%
  filter(nconst %in% Actorsplyr$nconst) %>% as.data.frame()

Actorsplyr
})
#5 Qué porcentaje de las películas realizadas en la década de los 80 tuvieron calificaciones superiores a 8? 
#Qué porcentaje de las películas realizadas en la década de los 90 tuvieron calificaciones superiores a 8? 
#Qué porcentaje de las películas con calificaciones superiores a 8 fueron realizadas en la década de los 70? 
#Qué porcentaje de las películas con calificaciones superiores a 8 fueron realizadas en la década de los 80?

salida<-within(salidasql,{Decada<-ifelse(startYear>=1970 & startYear<1980, "70s","")
Decada<-ifelse(startYear>=1980 & startYear<1990, "80s","Decada")
Decada<-ifelse(startYear>=1990 & startYear<2000, "90s","Decada")
mayor8<- ifelse(averageRating > 8, "si","no")})

mytable( ~ Decada*mayor8, data=salida)



#######################################################################################################################
###################################################################################################################
###################################################################################################################
#3English Premier League

s1415 <- read_excel("season-1415.xlsx",sheet="season-1415")
s1516 <- read_excel("season-1516.xlsx",sheet="season-1516")
s1617 <- read_excel("season-1617.xlsx",sheet="season-1617")
s1718 <- read_excel("season-1718.xlsx",sheet="season-1718")
s1819 <- read_excel("season-1819.xlsx",sheet="season-1819")

todos <- rbind(s1415,s1516,s1617,s1718,s1819)
str(todos)
## se crean dataframes utiles.
partA <- data.frame(Season=todos$Season,date=as.character(todos$Date),Team=todos$HomeTeam,GolesAF=todos$FTHG,
                    GolesEC=todos$FTAG,Tiros=todos$HS,TirosP=todos$HST,R=todos$HR)
partB <- data.frame(Season=todos$Season,date=as.character(todos$Date),Team=todos$AwayTeam,GolesAF=todos$FTAG,
                    GolesEC=todos$FTHG,Tiros=todos$AS,TirosP=todos$AST,R=todos$AR)
todos2 <- rbind(partA,partB)
todos2 <- within(todos2,{PG <- ifelse(GolesAF > GolesEC,1,0)
PE <- ifelse(GolesAF == GolesEC,1,0)
RC <- ifelse(R > 0,0,1)
})
str(todos2)

#1 En la temporada 16/17
# a) Cual fue el equipo en el primer lugar de la clasificación?
#Cuantos puntos obtuvo este equipo?
#Cual fue la diferencia entre el número de goles a favor y en contra de este equipo (Gol diferencia)?
#En qué porcentaje de sus partidos ganó este equipo?
#Qué porcentaje de sus disparos iban a la porteria rival?
#Qué porcentaje de sus partidos terminaron sin que ninguno de sus jugadores fuera expulsado?

###################### Solución sql ######################
system.time({sqldf("select Team, sum(3*PG+PE) as Puntos, 
      sum(GolesAF)-sum(GolesEC) as GolDif,
      100*avg(PG) as PPG, 
      100*avg(1-PG-PE) as PPP,
      100*sum(TirosP)/sum(Tiros) as PTP,
      100*avg(RC) as RC
      from todos2
      where Season='16-17'
      group by Team 
      order by Puntos desc, GolDif desc
      limit 2")})				

###################### Solución splyr ######################	   
system.time({todos2 %>% filter(Season=="16-17") %>%
  group_by(Team) %>%
  summarise(Puntos=sum(3*PG+PE),GolDif=sum(GolesAF)-sum(GolesEC),
            PPG=100*mean(PG),PPP=100*mean(1-PG-PE),
            PTP=100*sum(TirosP)/sum(Tiros),RC=100*mean(RC)) %>%
  arrange(desc(Puntos,Goldif)) %>%
  filter(row_number()<=2) %>%
  as.data.frame()})

########### Chelsea	93	52	78.94737	13.15789	35.17241	100

#En la temporada 17/18
#Cual fue el equipo en el tercer lugar de la clasificación?
#Cuantos puntos obtuvo este equipo?
#Cual fue la diferencia entre el número de goles a favor y en contra de este equipo (Gol diferencia)?
#En qué porcentaje de sus partidos ganó este equipo?
#Qué porcentaje de sus disparos iban a la porteria rival?
#Qué porcentaje de sus partidos terminaron sin que ninguno de sus jugadores fuera expulsado?

###################### Solución sql ######################
system.time({sqldf("select Team, sum(3*PG+PE) as Puntos, 
      sum(GolesAF)-sum(GolesEC) as GolDif,
      100*avg(PG) as PPG, 
      100*avg(1-PG-PE) as PPP,
      100*sum(TirosP)/sum(Tiros) as PTP,
      100*avg(RC) as RC
      from todos2
      where Season='17-18'
      group by Team 
      order by Puntos desc, GolDif desc
      limit 4")})	

###################### Solución splyr ######################	   
system.time({todos2 %>% filter(Season=="17-18") %>%
  group_by(Team) %>%
  summarise(Puntos=sum(3*PG+PE),GolDif=sum(GolesAF)-sum(GolesEC),
            PPG=100*mean(PG),PPP=100*mean(1-PG-PE),
            PTP=100*sum(TirosP)/sum(Tiros),RC=100*mean(RC)) %>%
  arrange(desc(Puntos,Goldif)) %>%
  filter(row_number()<=4) %>%
  as.data.frame()})


########### Tottenham	77	38	60.52632	18.42105	34.88746	94.73684

#Parte de la temporada 18/19 que se jugó durante 2018
#Cual fue el equipo en el primer lugar de la clasificación?
#Cuantos puntos obtuvo este equipo?
#Cual fue la diferencia entre el número de goles a favor y en contra de este equipo (Gol diferencia)?
#En qué porcentaje de sus partidos ganó este equipo?
#Qué porcentaje de sus disparos iban a la porteria rival?
#Qué porcentaje de sus partidos terminaron sin que ninguno de sus jugadores fuera expulsado?

###################### Solución sql ######################
system.time({sqldf("select Team, sum(3*PG+PE) as Puntos, 
      sum(GolesAF)-sum(GolesEC) as GolDif,
      100*avg(PG) as PPG, 
      100*avg(1-PG-PE) as PPP,
      100*sum(TirosP)/sum(Tiros) as PTP,
      100*avg(RC) as RC
      from todos2
      where Season='18-19' and date < '2019-01-01'
      group by Team 
      order by Puntos desc, GolDif desc
      limit 4")	})			

###################### Solución splyr ######################	   
system.time({todos2 %>% filter(Season=="18-19" & date < '2019-01-01') %>%
  group_by(Team) %>%
  summarise(Puntos=sum(3*PG+PE),GolDif=sum(GolesAF)-sum(GolesEC),
            PPG=100*mean(PG),PPP=100*mean(1-PG-PE),
            PTP=100*sum(TirosP)/sum(Tiros),RC=100*mean(RC)) %>%
  arrange(desc(Puntos,Goldif)) %>%
  filter(row_number()<=4) %>%
  as.data.frame()})

########### Liverpool	54	40	85	0	41.0828	95

#Desde la temporada 14/15 hasta la 18/19
#Cuales equipos se mantuvieron en las primeras 4 posiciones de la clasificación final?
#Cuales equipos se mantuvieron en las primeras 5 posiciones de la clasificación final?
#Cuales equipos se mantuvieron en las primeras 6 posiciones de la clasificación final?
#Cuales equipos descendieron a la segunda división? Tenga en cuenta que los últimos tres equipos en la clasificación de cada temporada descienden a la segunda división.

###################### Solución sql ######################
system.time({clasificacion <- sqldf("select Season, Team, sum(3*PG+PE) as Puntos, 
                       sum(GolesAF)-sum(GolesEC) as GolDif
                       from todos2
                       group by Season, Team 
                       order by Season, Puntos desc, GolDif desc")})

###################### Solución splyr ######################						
system.time({clasificacion <- todos2 %>% group_by(Season,Team) %>%
  summarise(Puntos=sum(3*PG+PE),
            GolDif=sum(GolesAF)-sum(GolesEC)) %>%
  arrange(Season,desc(Puntos,Goldif)) %>%
  as.data.frame()})

clasificacion <- within(clasificacion, Posicion <- rep(1:20,5))

#################################
########### Parte (A) ###########
#################################

###################### Solución 1 ######################
system.time({sqldf("select Team
      from clasificacion
      where Posicion <= 4 
      group by Team
      having count(*) = 5")})

###################### Solución 2 ######################	   
system.time({clasificacion %>% filter(Posicion <= 4) %>%
  group_by(Team) %>%
  summarise(veces = n()) %>%
  filter(veces == 5) %>%
  select(!veces) %>% as.data.frame()})

########### Man City

#################################
########### Parte (B) ###########
#################################

###################### Solución 1 ######################
system.time({sqldf("select Team
      from clasificacion
      where Posicion <= 5 
      group by Team
      having count(*) = 5")})

###################### Solución 2 ######################	   
system.time({clasificacion %>% filter(Posicion <= 5) %>%
  group_by(Team) %>%
  summarise(veces = n()) %>%
  filter(veces == 5) %>%
  select(!veces) %>% as.data.frame()})

########### Man City, Tottenham

#################################
########### Parte (C) ###########
#################################

###################### Solución 1 ######################
system.time({sqldf("select Team
      from clasificacion
      where Posicion <= 6 
      group by Team
      having count(*) = 5")})

###################### Solución 2 ######################
system.time({clasificacion %>% filter(Posicion <= 6) %>%
  group_by(Team) %>%
  summarise(veces = n()) %>%
  filter(veces == 5) %>%
  select(!veces) %>% as.data.frame()})

########### Arsenal, Man City, Man United, Tottenham
