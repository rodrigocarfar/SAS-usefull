%macro DeleteFile(fn);
data _null_;
    fname="delfn";
    rc=filename(fname, "&fn");
    if rc = 0 and fexist(fname) then
       rc=fdelete(fname);
    rc=filename(fname);
run;
%mend DeleteFile;
