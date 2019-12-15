global class UpdateAccountFields implements Database.Batchable<sObject>{
   global final String Query;
   global final String objectName;
   

   global UpdateAccountFields(String e){
             Query='SELECT Id FROM Attachment where parentid in (select id from case) LIMIT 10'; objectName=e; 
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, 
                       List<sObject> scope){
                       
                       
      delete scope;
   }

   global void finish(Database.BatchableContext BC){
AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()];
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
string email ='nbk.999@gmail.com';
mail.setToAddresses(new String[] {email});
mail.setReplyTo('bk.nagineni@gmail.com');
mail.setSenderDisplayName('Batch Processing');
mail.setSubject('Batch Process Completed'+a.status);
mail.setPlainTextBody('Batch Process has completed');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });





   }

}