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

PROC COMPARE
BASE=BASEDB
COMPARE=COMPDB
MAXPRINT=(50,500);
ID key;
VAR value;
