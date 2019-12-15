public class RadioButton {
List<contact> selectcon;
public String selectedValue { get; set; }
private final contact con;
public string accountid{get;set;}
Public List<contact> getAllContacts()
{
    List<contact> allcons = [Select Id,FirstName,LastName,Email,Phone from Contact limit 5];
    return allcons;
} 
public RadioButton (ApexPages.StandardController stdController) 
{
    this.con= (contact)stdController.getRecord();
    accountid= ApexPages.currentPage().getParameters().get('accid');

}  
public PageReference test() 
{
        System.debug('SFDC: ' + selectedValue);
        PageReference pageRef;
        if(accountid!=null)
        {
            contact c = new contact(lastname='test',accountid=accountid);
            insert c;
            PageReference acctPage = new ApexPages.StandardController(c).view();
            acctPage.setRedirect(true);
            return acctPage;
        }
        else
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select radio button and procceed'));
            return null;
        }
        return null;
} 
Public void selectcon()
{
    String selcontactid = System.currentPagereference().getParameters().get('conid');
    Contact con = [Select Id,FirstName,LastName,Email,Phone from Contact where Id=:selcontactid];
    selectcon =  new List<contact>();
    selectcon.add(con);
}
Public List<contact> getselectedContact()
{
    return selectcon;
}
}