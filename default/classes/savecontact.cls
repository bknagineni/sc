Public class savecontact

{

Public string lastname{get;set;}

Public string mailid{get;set;}

Public void insertcontact()

{

Contact cont=new contact (lastname=lastname, email=mailid);

Insert cont;

}

}