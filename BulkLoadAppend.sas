%macro BulkLoadAppend(from,to);
proc append base = &to (BULKLOAD=yes)
data = &from FORCE; 
run;
%mend  BulkLoadAppend;
