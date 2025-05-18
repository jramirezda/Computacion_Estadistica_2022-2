data Municipios;
set Municipios;
Municipio2 = lowcase(Municipio);/*hacemos la modificación */
Municipio2 = compress(Municipio2,"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");
Municipio2 = strip(Municipio2);
Municipio2 = compbl(Municipio2);
Municipio2 = propcase(Municipio2);
run;

proc print data=Municipios (obs=10) noobs; 
var Municipio Municipio2; /*analogo a municipios */
run;

data Municipios;
set Municipios;
Municipio = Municipio2;
drop Municipio2; /* usamos drop para quitar podria usar keep para escoger lo que dejo*/
run;
/*Modificamos el municipios */


Ejemplo 3 
/*limpia lo de departamento */
data Municipios;
set Municipios;
Departamento2 = lowcase(Departamento);
Departamento2 = compress(Departamento2,"abcdefghijklmnopqrstuvwxyzáéíóúüñ ","k");
Departamento2 = strip(Departamento2);
Departamento2 = compbl(Departamento2);
Departamento2 = propcase(Departamento2);
run;

proc print data=Municipios (obs=10) noobs;
var Departamento Departamento2;
run;

data Municipios;
set Municipios;
Departamento = Departamento2;
drop Departamento2;
run;

/*ejemplo 4*/
/* si quiero usar el if mas largo es if 
if ______ then do;
    las cosas 
end;*/
data Municipios2;
set Municipios;
/* substr busca lo que le digo desde el tercero hasta tres luego*/
if substr(Depmun,3,3) = "001" then Tipo = "Capital";
else Tipo = "Otro";
if Depmun="25001" then Tipo = "Otro";
run;

data Municipios3;
set Municipios;
if Depmun = cats(Dep,"001") then Tipo = "Capital";
else Tipo = "Otro";
if Depmun="25001" then Tipo = "Otro";
run;

/*comparacion de los dos datos*/ */
proc compare base=Municipios2 compare=Municipios3;
run;

data Municipios;
set Municipios2;
run;

proc print data=Municipios (obs=10) noobs;
var Dep Departamento Depmun Municipio Tipo;
where Tipo="Capital";
run;
/*ejemolo 6*/ */
data Municipios;
set Municipios;
Denspobl = Poblacion/Superficie;
Zona = "Urbano"; 
if Irural >= 40 then Zona = "Rural";
run;

/*7*/ */
data Vocales;
set Municipios;
Municipio2 = ktranslate(lowcase(Municipio),"aeiou","áéíóú");
where prxmatch('^a.*a$|^e.*e$|^i.*i$|^o.*o$|^u.*u$',Municipio2);
keep Dep Departamento Depmun Municipio;      
run;

data Vocales2;
set Municipios;
Municipio2 = ktranslate(lowcase(Municipio),"aeiou","áéíóú");
where substr(Municipio2,1,1)=substr(Municipio2,length(Municipio2),1) and
      substr(Municipio2,1,1) in ("a","e","i","o","u");
keep Dep Departamento Depmun Municipio;      
run;

proc compare base=Vocales compare=Vocales2;run;

proc print data=Vocales noobs;
var Dep Departamento Depmun Municipio;
run;

    