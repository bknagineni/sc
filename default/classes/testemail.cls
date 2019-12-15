public class testemail
{
private final User ur;
public testemail(ApexPages.StandardController controller)
{
this.ur=(User)controller.getRecord();
}
List<EmailTemplate> lstEmailTemplate =[Select Body,Subject From EmailTemplate where DeveloperName='Test_Translation_1'];
public void SendEmail()
{

if(lstEmailTemplate.get(0).Body != null )
{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
//mail.setTargetObjectId(ur.Id);
mail.setTargetObjectId('00590000001ThTc');

mail.setTemplateId('00X90000000X0cj');
mail.setSaveAsActivity(false);
Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
}

}
}