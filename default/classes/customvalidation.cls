public class customvalidation
{
    

    Account act;
    public PageReference save()
    {
        try
        {
            update act;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
        return null;
    }
    public String getName() {
        return 'customvalidation';
    }
    public Account getAccount() 
    {
        if(act== null)
        act= [select  name, numberoflocations__c from Account
            where id = :ApexPages.currentPage().getParameters().get('id')];
        return act;
    }
}