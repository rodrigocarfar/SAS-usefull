FILENAME mensagem EMAIL TO=("tomail@teste.com") 
   FROM=("frommail@teste.com")
   SUBJECT="Mensagem de teste"; 
  /*ATTACH=&anexo;*/ 
DATA _null_;
  FILE mensagem;
  PUT "Texto no corpo da mensagem";
RUN;
