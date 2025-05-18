/*1
si estoy exportando
si no se coloca libreria como "sashelp" se asume libreria words
se debe terminar con run 
se cambia con ;*/
proc export data=sashelp.stocks dbms= tab outfile= "/home/u62463561/CE2022-2/stocks.txt" replace;
delimiter=",";
run;

/*2 
vamos a importar
el firstobs es el endonde empiezan los datos
informat dice como va a leer los datos en que formato
$10 un formato date otro y comma otro el comma entiende las comas dentro de numero y demas 
en que formato lee format, el comma10.0 incluye */

data stockstxt;
infile "/home/u62463561/CE2022-2/stocks.txt" dsd delimiter="," firstobs=2;
informat Stock $10. Date date. Open High Low Close Volume AdjClose comma.;
format Date ddmmyy. Open High Low Close AdjClose dollar8.2 Volume comma10.0;
input Stock Date Open High Low Close Volume AdjClose;
run;
/*3 
*/
filename a "/home/u62463561/CE2022-2/stocks.dat";
proc export data=sashelp.stocks dbms= dlm outfile=a replace;
delimiter=";";
run;
/*4*/
data stockstxt;
infile "/home/u62463561/CE2022-2/stocks.dat" dsd delimiter="," firstobs=2;
informat Stock $10. Date date. Open High Low Close Volume AdjClose comma.;
format Date ddmmyy. Open High Low Close AdjClose dollar8.2 Volume comma10.0;
input Stock Date Open High Low Close Volume AdjClose;
run;

/*5*/
filename b "/home/u62463561/CE2022-2/shoes.csv";
proc export data=sashelp.shoes dbms=csv outfile=b replace;
delimiter="09"x;
run;

/*6*/
data shoescsv;
infile "/home/u62463561/CE2022-2/shoes.csv" dsd delimiter="09"x firstobs=2;
informat Region Product Subsidiary $25. Sales Inventory Return comma10.;
format Sales Inventory Return dollar10.;
input Region Product Subsidiary Stores Sales Inventory Return;
run;
/*7*/
filename b "/home/u62463561/CE2022-2/shoes.dlm";
proc export data=sashelp.shoes dbms=dlm outfile=b replace;
delimiter="&";
run;

/*8*/
data shoesdlm;
infile "/home/u62463561/CE2022-2/shoes.dlm" dsd delimiter="&" firstobs=2;
informat Region Product Subsidiary $25. Sales Inventory Return comma10.;
format Sales Inventory Return dollar10.;
input Region Product Subsidiary Stores Sales Inventory Return;
run;
/*9*/
filename d "/home/u62463561/CE2022-2/shoes.xlsx";
proc export data=sashelp.shoes dbms=xlsx outfile=d replace;
sheet="Zapatos";
run;
/*10*/
proc import out=shoesxlsx dbms=xlsx datafile=d replace;
getnames=yes;
sheet="Zapatos";
run;
/*11*/
filename donde "/home/u62463561/CE2022-2/ukcars.dat";
data ukcars;
infile donde truncover;
format Commercial Passengers comma10.;
input Year 5. Month $6. Commercial 7. Passengers 6.;
run;
/*12*/
filename donde "/home/u62463561/CE2022-2/grunfeld.dat";
data grunfeld;
infile donde truncover;
format Investment Value Capital comma10.;
input Firm $20. Year 5. Investment 8. Value 9. Capital 7.;
run;
/*1 print*/
proc print data=sashelp.iris noobs;
var Species SepalLength PetalWidth;
run;
/*2 
con el where filtro con cosas que pido*/
proc print data=sashelp.iris noobs;
var Species SepalLength SepalWidth PetalLength PetalWidth;
where Species in ("Setosa","Versicolor") and PetalLength < 40;
run;
/*3*/
proc print data=sashelp.iris (firstobs=1 obs=10) noobs;
var Species SepalLength SepalWidth PetalLength PetalWidth;
where Species="Virginica";
run;
/*4*/
proc print data=sashelp.iris (firstobs=20 obs=30) noobs;
where Species="Versicolor";
run;
/*data step*/
/**/
filename donde "/home/u62463561/CE2022-2/Municipios.xlsx";
proc import datafile=donde dbms=xlsx out=Municipios replace;
getnames=yes;
run;

proc contents data=Municipios varnum;
run;

proc print data=Municipios (obs=10) noobs;
run;
/*1*/
%include "/home/u62463561/CE2022-2/mismacros.sas";
%missings(Municipios);
/*2 sobreescribiendo*/
data Municipios2;
set Municipios;
where dep="05";
run;

data Municipios;
set Municipios;
Municipio2 = lowcase(Municipio);
Municipio2 = compress(Municipio2,"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");
Municipio2 = strip(Municipio2);
Municipio2 = compbl(Municipio2);
Municipio2 = propcase(Municipio2);
run;

proc print data=Municipios (obs=10) noobs;
var Municipio Municipio2;
run;
/*tambien podia usar keep*/
data Municipios;
set Municipios;
Municipio = Municipio2;
drop Municipio2;
run;

proc contents data=Municipios varnum;
run;