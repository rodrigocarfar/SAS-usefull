data cars;
  set sashelp.cars(obs=5);
run;

proc datasets lib=work nolist;
change cars = listofcars;
quit;
run;
