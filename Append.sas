%macro Append(from,to);
proc append base = &to(BULKLOAD=YES)
data = &from; 
run;
%mend Append;
