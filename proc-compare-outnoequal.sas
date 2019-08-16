DATA BASEDB(keep=key value);
  array values {5}  $1. _temporary_ ("A", "B", "C", "D", "E");
  do i=1 to 5;
    key=i*10;
	value="VALUE "||values{i};
	output;
  end;
RUN;

DATA COMPDB(keep=key value);
  array values {5}  $1. _temporary_ ("A", "B", "C", "D", "E");
  do i=1 to 3;
    key=i*10;
	value="VALUE "||values{i};
	output;
  end;
  do i=4 to 5;
    key=i*10;
	value="VALUE "||values{i-1};
	output;
  end;
RUN;

TITLE 'BASEDB';
PROC PRINT DATA=BASEDB;RUN;
TITLE 'COMPDB';
PROC PRINT DATA=COMPDB;RUN;

PROC COMPARE BASE=BASEDB COMPARE=COMPDB
OUT=RESULTDB1 OUTNOEQUAL OUTBASE
NOPRINT;
ID key;
VAR value;
RUN;

TITLE 'RESULTDB OUTBASE';
PROC PRINT DATA=RESULTDB1;RUN;

PROC COMPARE BASE=BASEDB COMPARE=COMPDB
OUT=RESULTDB2 OUTNOEQUAL OUTCOMPARE
NOPRINT;
ID key;
VAR value;
RUN;

TITLE 'RESULTDB OUTCOMPARE';
PROC PRINT DATA=RESULTDB2;RUN;
