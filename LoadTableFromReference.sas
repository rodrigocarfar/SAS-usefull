%macro LoadTableFromReference(fromLib,toLib);
proc contents data=&fromLib.._all_ directory out=SASDT memtype=data noprint; run;
PROC SQL NOPRINT;
  SELECT DISTINCT MEMNAME INTO :sasname1-:sasname999 FROM SASDT;
PROC SQL;
  SELECT COUNT(*) INTO :sasdtct from (select distinct MEMNAME FROM SASDT);
%do n=1 %to &sasdtct;
  %let arqsasBase=&&sasname&n;
  %if %sysfunc(exist(&toLib..&arqsasBase)) %then %do;
    proc append base = &toLib..&arqsasBase (BULKLOAD=yes)
     data = &fromLib..&arqsasBase FORCE; 
    run;
  %end;
%end;
%mend LoadTableFromReference;
