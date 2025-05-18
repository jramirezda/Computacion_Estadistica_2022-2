%macro missings(data);
proc contents data=&data noprint out=info;
run;
proc sql noprint;
select count(*) into: numrows 
from &data;
select count(*) into: numcols 
from info;
select name into: vars1- 
from info;

%do i=1 %to &numcols;
proc sql noprint;
create table piece&i as
select nmiss(&&vars&i) as Frequency
from &data;
%if &i > 1 %then %do;
data piece1;
set piece1 piece&i;
run;
proc datasets library=work nolist;
delete piece&i;
run;
%end;
%end;
data piece1;
set info(keep=name type varnum);
set piece1;
Percent = 100*Frequency/&numrows;
rename Name = Variable;
if Type = 2 or Type = 6 then Type2 = "Character";
if Type = 1 then Type2 = "Numeric"; 
drop Type;
rename Type2 = Type;
run;
proc sort data=piece1;by varnum;run;
title "Valores perdidos por variable";
proc print data=piece1 noobs;
var Variable Type Frequency	Percent;
format Percent 5.2;
sum Frequency;
run;
data temp;set &data;
Missings = cmiss(of _all_)-1;run;
title "Valores perdidos por individuo";
ods noproctitle;
proc freq data=temp;
table missings;run;
proc datasets library=work nolist;
delete info temp piece1;run;
%mend;

%macro categories(data,var,m,newvar);
%let a = %sysevalf(100/&m);
%let b = %sysevalf(100*(&m-1)/&m);
proc univariate data=&data noprint;
var &var;
output out=temp pctlpre=P_ pctlpts= &a to &b by &a;
run;
proc transpose data=temp out=temp2;run;
proc sql noprint;select col1 into: percs1- from temp2;
data &data;set &data;
if &var <= &percs1 then &newvar=1;
%do i=1 %to (&m-1);
%put Limite categoria &i : &percs%eval(&i+1);
if &var > &&percs&i then &newvar=&i+1;
%end;
run;
proc datasets library=work nolist;delete temp temp2;run;
%mend;