public with sharing class ExtendSampleController
{
   public string str = 'hello';
   public List<selectoption> AccountPicklist{get; set;}
    public PageReference SampleProjects() {
        return null;
    }
    public String TestNumber() {
        return str;
    }


    private final List<Sample__c> objsam;
    public ExtendSampleController(ApexPages.StandardController controller) {
            objsam= [select id,name,Project_Name__c,Description__c from Sample__c where Project_Name__c like '%sm%'];
    }

    //retreving projectname from exSampleRetreive page
    public String prjName
    {
        get{return prjName;}
        set{prjName=value;}
    }
    public ExtendSampleController()
    {
        AccountPicklist= new List<selectOption>();
        AccountPicklist.add(new selectOption('', '- None -'));
        List<Account> lstaccount = new list<Account>();
        lstaccount = [select id,name from account limit 5];
        SelectOption firstOption = new SelectOption('', ' - Select Account' + ' -');
        AccountPicklist.add(firstOption);
        for (Account objaccount:lstaccount) 
        {
                AccountPicklist.add(new SelectOption(objaccount.id,objaccount.name));
        }
    }
    public Sample__c[] getProjects()
    {
       Sample__c[] objPrjList= [select id,name,Project_Name__c,Description__c,Technologies__c from Sample__c];
       return objPrjList;     
    }
    public String geturlvalue()
    {
        return ApexPages.currentPage().getParameters().get('name');
    }
    public Pagereference navigateUrl()
    {
        return page.exSampleInsert;
    }
    /*public Pagereference  doSearch()
    {
        return [select id,name,Project_Name__c,Description__c from Sample__c where Project_Name__c like '%sm%'];
    }*/
    // search implentation
    
    public List<Sample__c> getSampleProjects()
    {
        return objsam;
    }
    public void getAccounts()
    {
       
       List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('', '- None -'));
        List<Account> lstaccount = new list<Account>();
        lstaccount = [select id,name from account limit 5];
        SelectOption firstOption = new SelectOption('', ' - Select Account' + ' -');
        options.add(firstOption);
        for (Account objaccount:lstaccount) 
        {
                options.add(new SelectOption(objaccount.id,objaccount.name));
        }
        //retun options;
    }

 }