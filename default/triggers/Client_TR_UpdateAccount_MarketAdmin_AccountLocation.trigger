//trigger Client_TR_UpdateAccount_MarketAdmin_AccountLocation on CVM_SC__Account_Location__c (before insert, before update,after insert,after update)
trigger Client_TR_UpdateAccount_MarketAdmin_AccountLocation on contact(after update)
{
    List<Account> listAccount = new List<Account>();
    Set<Id> accountIds = new Set<Id>();
    for(contact accountlocation : Trigger.New)
       {
           //CVM_SC__Account_Location__c accLoc = [SELECT id,CVM_SC__Account__c FROM CVM_SC__Account_Location__c WHERE Id =: accountlocation.Id and CVM_SC__b_HQ_FLAG__c=true];
            
            if (contact.accountid!=null) 
            {
             account acc=[select name,id,ownerid from account where id=:accountlocation.accountid];
             acc.ownerid=accountlocation.MileageHelper__check_owner__c;
             update acc; 
            } 
           
       }
        
}