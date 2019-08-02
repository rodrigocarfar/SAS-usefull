filename arqs '\\my\folder\wildcard\*.log';

DATA ARQUIVOS;
  ATTRIB filename fn length=$300;
  RETAIN filename;
  INFILE arqs filename=fn;
  input;
  if filename ^= fn then do;
    filename=fn;
    output;
  END;
RUN;
