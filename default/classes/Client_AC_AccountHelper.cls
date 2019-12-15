public class Client_AC_AccountHelper
{

    public  Account acc {get; private set;} 
    ApexPages.StandardController stdController;
    public list<SelectOption> pickList {get; private set;}
    public String selectedId {get; set;}
    public List<WrapperClass> listWrapper {get;set;}
    public Boolean allBool {get;set;}
    
    
    public Client_AC_AccountHelper(ApexPages.StandardController Controller) 
    {  

        stdController = Controller;                
        this.acc= (Account)stdController.getRecord(); 
    
        List<selectOption> options = new List<selectOption>();
        options.add(new selectOption('', '- None -'));
        List<Account> lstaccount = new list<Account>();
        lstaccount = [select id,name from account limit 5];
        if (pickList == null) {
            pickList = new list<SelectOption>();
        }
        SelectOption firstOption = new SelectOption('', ' - Select Account' + ' -');
        pickList.add(firstOption);
        for (Account objaccount:lstaccount) 
        {
                this.pickList.add(new SelectOption(objaccount.id,objaccount.name));
        }
        
    }
    
    //selected account from vfp
    
    //Opportunities display based on Account selection and bulk save
    
    public Client_AC_AccountHelper() 
    {
        listWrapper = new List<WrapperClass>();
        system.debug('Selected Accountid--------------------'+selectedId);
        List<Opportunity> listopps = [SELECT Id, Name,stagename FROM Opportunity where accountid=:selectedId];
        if(listopps.size() > 0) {
        system.debug('listopps--------------------'+listopps);
            for(Opportunity opp : listopps) {
                listWrapper.add(new WrapperClass(opp));
            }
        }
    }
    
    
    public class WrapperClass {
        public Boolean checked {get;set;}
        public Opportunity opp {get;set;}
        
        public WrapperClass(Opportunity opp) {
            this.opp= opp;
            system.debug('opp--------------------'+opp);
        }
    }
    
      
    public void saveOpps() {
         system.debug('listWrapper--------------------'+listWrapper);
        List<Opportunity> listOpps = new List<Opportunity>();
        List<WrapperClass> listTempWrapper = new List<WrapperClass>();
        for(WrapperClass w : listWrapper) {
            if(w.checked) {
                listOpps.add(w.opp);
                system.debug('--------------------'+listTempWrapper );
            } else {
                listTempWrapper.add(w);
                
            }
        }
        if(listOpps.size() > 0) {
            Update listOpps;
            system.debug('listOpps --------------------'+listOpps );
            listWrapper = listTempWrapper;
            system.debug('listTempWrapper--------------------'+listTempWrapper);
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select atleast one to save'));
        }
    }
    
    public void selectAll() {
        if(allBool) {
            for(WrapperClass w : listWrapper) {
                w.checked = true;
            }
        } else {
            for(WrapperClass w : listWrapper) {
                w.checked = false;
            }
        }
    }
    
    
}