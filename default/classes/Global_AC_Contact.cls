global class Global_AC_Contact 
{
    // contact object
    global Contact objContact{get;set;}
    global string locationName{get;set;}
    global Account objAccount{get;set;}
    global string accountName{get;set;}
    global string accountId{get;set;}
    global Global_AC_Contact(ApexPages.StandardController controller)
    {
        try
        {
            accountId = '0019000001FNRST';
               //check if supplier Id is in request parameter
                if(ApexPages.currentPage().getParameters().get('supplierId') != null)
                    {
                        objContact.AccountId = ApexPages.currentPage().getParameters().get('supplierId');
                        
                    }
                     List<Account> lstAccount = [Select id, Name from Account where id =: objAccount.Id];
                        
                    if (lstAccount.size() > 0 )
                        {
                            accountName= lstAccount.get(0).Name ;
                           
                            
                        }
                        
                    if(objAccount.id != null)
                        {    
                            for(Account loc : lstAccount )
                                {
                                    if(loc.id == objAccount.Id)
                                        {
                                            accountName = loc.Name;
                                            
                                        }
                                } 
                        }   
        }
        catch(Exception ex)
        {
            
        }
}
//send mail
 public PageReference UseemailService()
    {
       
                //Send mail to execute the next batch apex call
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {'nbk.999@gmail.com'};
                mail.setToAddresses(toAddresses);
                mail.setSubject('Call Dashboard Batch Apex');
                mail.setPlainTextBody('Batch apex call through email');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
                return null;  
                   
    }
    //send email 
    public pageReference sendEmailtoPortalUser()
           {
                                    
                //Messaging.MassEmailMessage  mail = new Messaging.MassEmailMessage();
                List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                 
                List<EmailTemplate> lstEmailTemplate =[Select id,HtmlValue,Subject From EmailTemplate where DeveloperName='TestingActivity'];
                
                String  templateId;
                
                if(lstEmailTemplate.size()>0)
                {
                  templateId = lstEmailTemplate[0].id;
                }
                
                if (lstEmailTemplate.size() > 0)
                {
                       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        //mail.setSubject(lstEmailTemplate.get(0).Subject.replace('@@ClientName',appConfig.Client_Name__c));
                       mail.setTargetObjectId('00590000005BR1T');
                       mail.setTemplateId(templateId);
                        mail.setSaveAsActivity(false);
                        //mail.setHtmlBody(HtmlValue);
                        //mail.setPlainTextHtmlValue(HtmlValue);
                        mails.add(mail);
                    
                    Messaging.sendEmail(mails);
                }
                
                return null;
           }    
}