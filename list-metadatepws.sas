%macro Auth(AuthenticationDomain);
%global Password UserID;
*data &AuthenticationDomain;
data _null_;
   length uri UserId Password UserId AuthId AuthenticationDomain $256;
   rc=metadata_getnobj("omsobj:AuthenticationDomain?@Name='&AuthenticationDomain'",1,uri);
   rc=metadata_getattr(uri,"Id",AuthId);
   rc=1;
   tn=1;
do while(rc>0);
    rc=metadata_getnasn("OMSOBJ:AuthenticationDomain\"!!AuthId,"Logins",tn,uri);
     if rc>0 then do;
        arc=metadata_getattr(uri,"UserID",UserID);
        arc=metadata_getattr(uri,"Password",Password);
	    output;
        put 'USER=' UserID 'PASSWORD="' Password +(-1) '"';
     end;
     tn=tn+1;
end;
run;
%put NOTE: For AuthenticationDomain &AuthenticationDomain., the UserID &UserID has password &Password.. Executed as &sysuserid..;
%mend;

%Auth(MYDOMAIN)
