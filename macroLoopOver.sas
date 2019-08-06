/* Call any macro that receives 1 parm and loop over the values */
/* Each value must be separated by spaces                       */
/* Rodrigo CarFar                                               */
%macro macroLoop(macroname,values);
 %let i=1;
 %let value=%scan(&values,&i," ");
 %do %while (%length(&value)^=0);
  %&macroname(&value);
  %let i=%eval(&i+1);
  %let value=%scan(&values,&i," ");
 %end;
%mend macroLoop;
