/* Get the installed R version */
PROC OPTIONS OPTION=RLANG; RUN;
PROC IML;	
	SUBMIT/R; 
		version
	ENDSUBMIT;
QUIT;

proc setinit;run;

/* Import sas dataset to be used inside the R code */
proc iml;
call ExportDataSetToR("Sashelp.cars", "cars" );
submit / R;
   names(cars)
endsubmit;

/* Export data from R code to SAS work */
proc iml;
submit / R;
df <- trees
endsubmit;
run ImportDataSetFromR( "WORK.trees", "df" );
submit;
proc print data=trees;
run;
endsubmit;

