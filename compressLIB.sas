%macro compressLIB(dir);
libname SASLIB "&dir";
ods output attributes=SASDT;
proc contents data=SASLIB._all_; run;
PROC SQL NOPRINT;
  SELECT COUNT(*) INTO :sasdtct FROM SASDT WHERE Label2="Compressed" and CValue2="NO";
PROC SQL NOPRINT;
  SELECT Member INTO :sasname1-:sasname999 FROM SASDT WHERE Label2="Compressed" and CValue2="NO";
%do n=1 %to &sasdtct;
  %let arqsas=&&sasname&n;
  %let arqsasBase=%sysfunc(tranwrd(&arqsas,SASLIB.,));
  DATA &arqsas.X(COMPRESS=YES);
    SET &arqsas;
  RUN;
  %if %sysfunc(exist(&arqsas.X))
  %then %do;
    proc datasets lib=SASLIB nolist;
      DELETE &arqsasBase;
      CHANGE &arqsasBase.X=&arqsasBase;
    quit;
  %end;
%end;
%mend compressLIB;
