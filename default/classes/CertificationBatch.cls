global with sharing class CertificationBatch implements Database.Batchable<Sobject>,Database.stateful    
{
    public String query;        
    public String parsedQuery;        
    public integer i=0;   
    public String sfid='00190000006QEze'; 
    //sfid='00190000006QEze';     
    //public List<cvm_sc__AccountCertification__c> listOfCertifications{get; set;}       
     public List<Boolean> listSuppDivCatToBeInserted;                 
      //constructor        
      global CertificationBatch()          
       {
                          
           try               
           {
               
           }
           catch(Exception e)
           {
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
                 String[] toAddresses = new String[] {'balakrishna.nagineni@cvmsolutions.com','Yugender.Challa@cvmsolutions.com'};         
                 mail.setToAddresses(toAddresses);                     
                 mail.setSubject('At Constructor catch::'+ system.now()+limits.getScriptStatements ()+ 'No left::'+limits.getLimitScriptStatements () +'heapsize::'+limits.getHeapSize ()+'left'+limits.getLimitHeapSize());                   
                 mail.setPlainTextBody(e.getmessage()+string.valueof(e.getLineNumber())+e.getStackTraceString());                  
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           }
       }//end constructor
       global database.Querylocator start(Database.BatchableContext context)           
        {                  
         try                
         {
             
             query='select id,name from account where id=:sfid';
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
             String[] toAddresses = new String[] {'balakrishna.nagineni@cvmsolutions.com','Yugender.Challa@cvmsolutions.com'};         
                 mail.setToAddresses(toAddresses);                     
                 mail.setSubject('At Constructor catch::'+ system.now()+limits.getScriptStatements ()+ 'No left::'+limits.getLimitScriptStatements () +'heapsize::'+limits.getHeapSize ()+'left'+limits.getLimitHeapSize());                   
                 //mail.setPlainTextBody(e.getmessage()+string.valueof(e.getLineNumber())+e.getStackTraceString());                  
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         }
         catch(Exception e)                  
         {
               
         }
         return Database.getQueryLocator(query);
        }//end query locator 
        global void execute(Database.BatchableContext context , Sobject[] scope)            
        {                             
        try
        {
              delete scope;  
              
        }
        catch(Exception e)                  
         {
               
         }
      }//end execute
      
      global void finish(Database.BatchableContext BC){
// Get the ID of the AsyncApexJob representing this batch job  
// from Database.BatchableContext.  
// Query the AsyncApexJob object to retrieve the current job's information.  

AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
  TotalJobItems, CreatedBy.Email
  from AsyncApexJob where Id =:BC.getJobId()];
// Send an email to the Apex job's submitter notifying of job completion.  

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {a.CreatedBy.Email};
mail.setToAddresses(toAddresses);
mail.setSubject('Apex Sharing Recalculation ' + a.Status);
mail.setPlainTextBody
('The batch Apex job processed ' + a.TotalJobItems +
' batches with '+ a.NumberOfErrors + ' failures.');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}



         
}