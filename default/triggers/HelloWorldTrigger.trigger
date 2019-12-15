trigger HelloWorldTrigger on Account (before insert,after insert,before update) {
if(Trigger.isInsert ||Trigger.isUpdate){
    for(Account a : Trigger.New) {
        a.NumberOfEmployees= 10;
        
    }   
    }
}