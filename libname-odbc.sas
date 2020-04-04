libname mylib odbc noprompt="driver=PostgreSQL ANSI(x64); server=XXXXXXX;uid=YYYYY;pwd=xxxxxxxx; database=dbname" schema=public;
libname mylib odbc noprompt="driver=SQL Server;server=XXXXXXX;uid=YYYYY;pwd=xxxxxxxx; database=dbname" schema=dbo;
libname mylib odbc noprompt="driver={SQLite3 ODBC Driver};database=\\my\folder\MySQLite.db;OEMCP=1;";
libname mylib odbc noprompt="driver=SQL Server;server=MYSERVER;uid=YYYYYY; pwd=XXXXX; database=MYDB; trusted_connection=yes;" schema=schema_name;
