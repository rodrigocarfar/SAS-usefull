PROC OPTIONS OPTION=RLANG; RUN;
PROC IML;	
	SUBMIT/R; 
		version
	ENDSUBMIT;
QUIT;

proc setinit;run;

proc iml;
call ExportDataSetToR("Sashelp.cars", "cars" );
submit / R;
   names(cars)
endsubmit;

proc iml;
submit / R;
df <- trees
endsubmit;

run ImportDataSetFromR( "WORK.trees", "df" );

submit;
proc print data=trees;
run;
endsubmit;

proc iml;
submit / R;
df <- trees
endsubmit;
run ImportDataSetFromR( "WORK.trees", "df" );
submit;
proc print data=trees;
run;
endsubmit;
