DATA DB(keep=key value);
  array values {5}  $1. _temporary_ ("A", "B", "C", "D", "E");
  do i=1 to 5;
    key=i*10;
	value="VALUE "||values{i};
	output;
  end;
RUN;

TITLE 'DB BEFORE CHANGES';
PROC PRINT DATA=DB;RUN;

DATA UPDT(keep=key value);
  key=30;value="VALUE F";OUTPUT;
  key=60;value="VALUE H";OUTPUT;
RUN;

TITLE 'TRANSACTION RECORDS';
PROC PRINT DATA=UPDT;RUN;


DATA DB;
  MODIFY DB UPDT
  UPDATEMODE=NOMISSINGCHECK;
  BY key;
  select (_IORC_);
    when (%SYSRC(_SOK)) do;
      replace;
    end;
    when (%sysrc(_DSENMR)) do;
      _error_=0;
      output;
    end;
    otherwise do;
      put 'ERROR IN MODIFY';
      stop;
    end;
  end;
RUN;

TITLE 'DB AFTER CHANGES';
PROC PRINT DATA=DB;RUN;
