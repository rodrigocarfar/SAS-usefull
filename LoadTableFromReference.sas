%macro LoadTableFromReference(fromLib,toLib);
ods output attributes=SASDT;
proc contents data=&fromLib.._all_; run;
PROC SQL NOPRINT;
  SELECT DISTINCT Member INTO :sasname1-:sasname999 FROM SASDT;
PROC SQL;
  SELECT COUNT(*) INTO :sasdtct from (select distinct Member FROM SASDT);
%do n=1 %to &sasdtct;
  %let arqsas=&&sasname&n;
  %let arqsasBase=%sysfunc(tranwrd(&arqsas,&fromLib..,));
  %if %sysfunc(exist(&toLib..&arqsasBase)) %then %do;
    proc append base = &toLib..&arqsasBase (BULKLOAD=yes)
     data = &arqsas FORCE; 
    run;
  %end;
%end;
%mend LoadTableFromReference;
