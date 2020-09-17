%macro Append(from,to);
proc append base = &to
data = &from; 
run;
%mend Append;
