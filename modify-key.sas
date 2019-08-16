DATA DB(keep=key value);
  array values {5}  $1. _temporary_ ("A", "B", "C", "D", "E");
  do i=1 to 5;
    key=i*10;
	value="VALUE "||values{i};
	output;
  end;
  do i=1 to 2;
    key=i*10;
	value="VALUE "||values{i+1};
	output;
  end;
RUN;

PROC SORT DATA=DB; BY KEY; RUN;

TITLE 'DB BEFORE CHANGES';
PROC PRINT DATA=DB;RUN;

DATA UPDT(keep=key new_value);
  key=10;new_value="VALUE X";OUTPUT;
  key=20;new_value="VALUE Z";OUTPUT;
RUN;

TITLE 'TRANSACTION RECORDS';
PROC PRINT DATA=UPDT;RUN;

PROC SQL NOPRINT;
  CREATE INDEX key ON DB (key);

DATA DB;
SET UPDT;
  DO UNTIL (_iorc_=%sysrc(_dsenom));
    MODIFY DB KEY=key;
    select (_IORC_);
      when (%SYSRC(_SOK)) do;
	    value=new_value;
        replace;
      end;
      when (%sysrc(_dsenom)) do;
        _error_=0;
      end;
      otherwise do;
        put 'ERROR IN MODIFY';
        stop;
      end;
    end;
  END;
RUN;

TITLE 'DB AFTER CHANGES';
PROC PRINT DATA=DB;RUN;
