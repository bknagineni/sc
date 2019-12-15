@isTest 
private class CaseAttachmentPurgeTest  {
    static testMethod void CaseAttachmentPurge() {
       Account a = new Account(Name='Behind the Cloud');
       // Insert book
       insert a;
       Contact con = new contact(lastname='testcontact',accountid=a.id);
       insert con;
       case cse = new case(type='Electrical',accountid=a.id,contactid=con.id);
       insert cse;
       //Attachment
       Attachment attach=new Attachment();      
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cse.id;
        insert attach;
        
       Test.StartTest();
       string objname ='Attachment';
       Id batchInstanceId = Database.executeBatch(new UpdateAccountFields(objname), 5);
       Test.StopTest();

       
    }
}