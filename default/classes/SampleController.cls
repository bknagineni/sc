public class SampleController
{

    public boolean IsCommentUpdate {get;set;}
    public Account acc {get;set;}
    public SampleController(ApexPages.StandardController stdController) 
    {
        this.acc = (Account)stdController.getRecord();
        if(acc.comments_1__c !=acc.comments_2__c)
        {
            IsCommentUpdate = true;
        }
        else
        IsCommentUpdate = false;
    }
}