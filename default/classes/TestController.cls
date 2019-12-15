public without sharing class TestController{ 


@RemoteAction 
public static void CreatepuserRemote() 
{ 
//sfdcuserfuture.createUser(); 

try 
{ 
List<profile> profileids = [select id from profile where name like '%High Volume Customer Portal%' LIMIT 1]; 
string profileid = profileids[0].id; 

Account acc = new Account(name = 'T1estAccNme'+string.valueof(math.Round(math.random()*10000)),ownerid='00590000000hJHu');
insert acc; 

Contact con = new Contact(Email = 'nbk.999@gmail.com', FirstName = 'TstFName'+string.valueof(math.Round(math.random()*10000)), LastName = 'TstLName'+string.valueof(math.Round(math.random()*10000)), Phone='5412541254', AccountID = acc.Id); 
insert con; 

string uname = 'Hari'+ string.valueof(math.Round(math.random()*10000))+'@gmail.com'; 

Database.DMLOptions dmo = new Database.DMLOptions(); 
dmo.EmailHeader.triggerUserEmail = true; 

// *****Change the email here to see if the email is being sent to the user 
User portalUser = new User(alias = 'standt', email = 'nbk.999@gmail.com', Phone = '5412541254', 
emailencodingkey = 'UTF-8', firstname = con.firstname, lastname = con.lastname , languagelocalekey = System.UserInfo.getLanguage(), 
localesidkey = 'en_US', profileid = profileid , contactId = con.id, 
timezonesidkey = 'America/Los_Angeles', username = uname ); 

portalUser.setOptions(dmo); 
insert portalUser; 

database.insert(portalUser,dmo); 
} 
catch(exception e) 
{ 
system.debug('@@@@Exceptionmsg'+e.getmessage()); 

} 

} 

}