data cars;
  set sashelp.cars(obs=5);
run;

proc print data=cars label;var Make Model Origin EngineSize;run;

proc datasets lib=work nolist;
  modify cars;
  label Make = 'Car Manufacturer'
        Model = 'Car Model';
  rename Origin=From 
         EngineSize=Power;
quit;
run;

proc print data=cars label;var Make Model From Power;run;
