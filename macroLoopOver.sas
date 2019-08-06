/* Call any macro thar receives just 1 parm for all values */
/* Each value must be separated by spaces                  */
%macro macroLoop(macroname,values);
 %let i=1;
 %let value=%scan(&values,&i," ");
 %do %while (%length(&value)^=0);
  %&macroname(&value);
  %let i=%eval(&i+1);
  %let value=%scan(&values,&i," ");
 %end;
%mend macroLoop;
