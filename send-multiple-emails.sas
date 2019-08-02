FILENAME mensagem EMAIL FROM=("teste@mycompany.com");

DATA EMAILS;
  ATTRIB emailto subject LENGTH=$100;
  emailto="dest1@mycompany.com";subject="Teste de envio de email para multiplos destinos sem macro";output;
  emailto="dest2@mycompany.com";subject="Teste de envio de email para multiplos destinos sem macro";output;
  emailto="dest3@mycompany.com";subject="Teste de envio de email para multiplos destinos sem macro";output;
RUN;  


DATA _NULL_;
  FILE mensagem;
  set EMAILS END=FIM;
  put '!em_to!' emailto;
  put '!em_subject!' subject;
  put 'Corpo da mensagem e endereço de email enviado:' emailto;
  put '!EM_SEND!';
  put '!EM_NEWMSG!';
  IF FIM THEN put '!EM_ABORT!';
RUN;

/*
The directives that change the attributes of your message are:

!EM_TO! addresses
Replace the current primary recipient addresses with addresses. In the PUT statement, specify addresses without single quotes.

!EM_CC! addresses
Replace the current copied recipient addresses with addresses. In the PUT statement, specify addresses without single quotes.

!EM_SUBJECT! subject
Replace the current subject of the message with subject.

!EM_ATTACH! pathname
Replace the names of any attached files with pathname.
The directives that perform actions are

!EM_SEND!
Sends the message with the current attributes. By default, the message is automatically sent at the end of the DATA step. If you use this directive, the SAS System sends the message when it encounters the directive, and again at the end of the DATA step.

!EM_ABORT!
Aborts the current message. You can use this directive to stop the SAS System from automatically sending the message at the end of the DATA step.

!EM_NEWMSG!
Clears all attributes of the current message, including TO, CC, SUBJECT, ATTACH, and the message body.
*/
