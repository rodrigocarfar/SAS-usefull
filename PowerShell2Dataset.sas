*Example reading Name and Id of processes in server;
*%PowerShell2Dataset(%STR(ps | select name,id),saida);

%macro PowerShell2Dataset(ps1cmd,sasds);
%let workdir=%sysfunc(getoption(work));
%let execbat=&workdir\execps1.bat;
%let resultcsv=&workdir\result.csv;
filename execbat "&execbat" lrecl=500;
data _null_;
  FILE execbat;
  PUT 'powershell -command "' @; 
  PUT "&ps1cmd " @;
  PUT "| ConvertTo-Csv -NoTypeInformation | Out-File &resultcsv -Encoding 'UTF8'" @;
  PUT '";exit;';
RUN;
data _null_;
 rc=system("&execbat");
 put rc=;
run;
filename rsultcsv "&resultcsv" lrecl=1000;
proc import file=rsultcsv
  out=&sasds
  dbms=csv
  replace;
  getnames=yes;
RUN;
%mend PowerShell2Dataset;
