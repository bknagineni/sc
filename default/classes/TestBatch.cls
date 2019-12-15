global with sharing class TestBatch implements Database.Batchable<Sobject>,Database.stateful    
{
     public String query; 
     public String sfid='Certification';    
    global Database.QueryLocator start(Database.BatchableContext BC) {
//passing the query string to the Database object.      
    query = 'select id from account where name=:sfid';
    system.debug ('hello'+query);
    return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {

// in this sample, we simply delete all the records in scope    
delete scope;
system.debug ('hello'+scope);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
             String[] toAddresses = new String[] {'balakrishna.nagineni@cvmsolutions.com','Yugender.Challa@cvmsolutions.com'};         
                 mail.setToAddresses(toAddresses);                     
                 mail.setSubject('At Constructor catch::'+ system.now()+limits.getScriptStatements ()+ 'No left::'+limits.getLimitScriptStatements () +'heapsize::'+limits.getHeapSize ()+'left'+limits.getLimitHeapSize());                   
                 mail.setPlainTextBody('testing purpose');                  
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    global void finish(Database.BatchableContext BC){
// Get the ID of the AsyncApexJob representing this batch job  
// from Database.BatchableContext.  
// Query the AsyncApexJob object to retrieve the current job's information.  

AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
  TotalJobItems, CreatedBy.Email
  from AsyncApexJob where Id =:BC.getJobId()];
// Send an email to the Apex job's submitter notifying of job completion.  

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {'balakrishna.nagineni@cvmsolutions.com'};
mail.setToAddresses(toAddresses);
mail.setSubject('Apex Sharing Recalculation ' + a.Status);
mail.setPlainTextBody
('The batch Apex job processed ' + a.TotalJobItems +
' batches with '+ a.NumberOfErrors + ' test.');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}



}