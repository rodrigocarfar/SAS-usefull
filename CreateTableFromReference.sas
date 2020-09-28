%macro CreateTableFromReference(fromLib,toLib);
proc contents data=&fromLib.._all_ directory out=SASDT memtype=data noprint; run;
proc contents data=&fromLib.._all_; run;
PROC SQL NOPRINT;
  SELECT DISTINCT MEMNAME INTO :sasname1-:sasname999 FROM SASDT;
PROC SQL;
  SELECT COUNT(*) INTO :sasdtct from (select distinct Member FROM SASDT);
%do n=1 %to &sasdtct;
  %let arqsasBase=&&sasname&n;
  %if not(%sysfunc(exist(&toLib..&arqsasBase))) %then %do;
    PROC SQL NOPRINT;
      CREATE TABLE &toLib..&arqsasBase AS
      SELECT * FROM &fromLib..&arqsasBase WHERE 1=0;
  %end;
%end;
PROC DELETE DATA=SASDT;RUN;
%mend CreateTableFromReference;
