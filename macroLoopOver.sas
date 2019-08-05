%macro macroLoop(macroname,values);
 %let i=1;
 %let valor=%scan(&values,&i," ");
 %do %while (%length(&value)^=0);
  %&macroname(&value);
  %let i=%eval(&i+1);
  %let value=%scan(&values,&i," ");
 %end;
%mend macroLoop;
