trigger myTrigger on Account (before delete) 
{
 if(System.Trigger.IsDelete)
   { 
        for (Account Accts : trigger.old) 
        {
          if (Accts.name != null)
            { 
                 AccountTriggerHelper.updateChildLocationMerge(Trigger.Old);
                 //Accts.addError('You cannot delete an Account Please contact your Salesforce.com Administrator for assistance.');
            }
        }
    } 
       
}