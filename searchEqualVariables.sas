%macro searchEqualVariables(base1,base2,namevar);
  %global &namevar;
  PROC CONTENTS DATA=&base1 OUT=BV01 NOPRINT;
  PROC CONTENTS DATA=&base2 OUT=BV02 NOPRINT;
  PROC SQL NOPRINT;
    SELECT t1.NAME INTO:&namevar separated by ','
    FROM BV01 t1,BV02 t2 
	WHERE UPCASE(t1.name)=UPCASE(t2.name) and UPCASE(t1.name)
	ORDER BY NAME;
  PROC DELETE DATA=BV01; RUN;
  PROC DELETE DATA=BV02; RUN;
%mend searchEqualVariables;
