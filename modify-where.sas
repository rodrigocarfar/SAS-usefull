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

DATA DB;
  MODIFY DB;
  WHERE key=30;
  value="VALUE F";
RUN;

TITLE 'DB AFTER CHANGES';
PROC PRINT DATA=DB;RUN;
