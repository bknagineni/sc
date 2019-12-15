public class ListsMapsController {

    public Map<String, String> inputFields { get; set; }
    public List<UserHistoryWrapper> listUserHistoryWrapper {get;set;}
    List<String> tempList = new List<String>();
    
        Set<String> tempSet = new Set<String>();
    public list<string>  strverify {get;set;} 
    public set<string>  setverify {get;set;}     
        
        
    public ListsMapsController() {
        inputFields = new Map<String, String> { 
            'firstName' => 'Jonny', 'lastName' => 'Appleseed', 'age' => '42' };
            
       getdetails();
        Set<String> setContactHistoryFields = new Set<String>();
        //getCustomSettings();                 
        tempList.add('One');
        //tempList.add('Two');
       // tempList.add('Three'); 
        //tempList.add('Three');  
        tempList.add('Mine');  
        String contactId;
        contactId = '0039000000LU8sP';
        tempSet.addAll(tempList); 
        setverify = tempSet;
        //actual wrapper class
          setContactHistoryFields.add('Email');
          setContactHistoryFields.add('Title');
          //setContactHistoryFields.add('Id');
        listUserHistoryWrapper = new List<UserHistoryWrapper>();
        MAP<Datetime , String> mapDatetime_DeactivationReason = new MAP<Datetime , String>();
        MAP<Datetime , String> mapDatetime_AssignedToID = new MAP<Datetime , String>();
                        
                List<ContactHistory> listConHis = [Select c.OldValue, c.NewValue, C.IsDeleted, c.Id, c.Field , c.CreatedDate, c.CreatedById, c.CreatedBy.Name , c.Contactid  From ContactHistory  c where c.Contactid =: contactId  order by createddate desc];
                string Email1;
                string oldEmail1;
                string title;
                for(ContactHistory conHis : listConHis)
                    {
                         if(conHis.Field.trim().toLowerCase()=='email')
                        {
                            Email1 = string.valueOf(conHis.NewValue);
                            oldEmail1 = string.valueOf(conHis.oldValue); 
                        } 
                        if(conHis.Field.trim().toLowerCase()=='title')
                        {
                            title = string.valueOf(conHis.NewValue);
                        }
                         listUserHistoryWrapper.add(new UserHistoryWrapper(conHis,Email1,oldEmail1,title ));
                    }
        //use map creation and retreive
        Map<String,Account> Map_Task_Frequency = new Map<String,Account>(); 
        for(Account a: [SELECT Name,Id FROM Account limit 5] )
        { Map_Task_Frequency.put(a.Name, a); }
        system.debug('mapvalues@@@'+Map_Task_Frequency);
    }

    public PageReference submitFieldData() {
        doSomethingInterestingWithInput();
        account a =new account(name='testfromclassaccount');
        insert a;
        return null;
    }
    
    public void doSomethingInterestingWithInput() {
        inputFields.put('age', (Integer.valueOf(inputFields.get('age')) + 10).format());
        inputFields.put('firstname', 'hello');
        
    }
    public void getdetails()
    {
        list<MileageHelper__ConfigurationSettings__c> lst1=UtilityClass.getConfigurationValues();
        
        system.debug('testing'+lst1);
        
    }
    public void getCustomSettings()
    {
        list<account> lstacc = [select id from account limit 5];
        system.debug('testing'+lstacc);
        
    }
      public Class UserHistoryWrapper 
            {
                
                
                //Will contain the dtae of the action on user
                //public Datetime DateOfAction {get;set;}
                public String DateOfAction {get;set;}
                //Name of the user who made the update action
                public String Username {get;set;}
                public Id ContactHistoryId {get;set;}
                public String Action {get;set;}
                public String oldEmail{get;set;}
                public String Email { get;set;}
                public String Title{ get;set;}
                
                public UserHistoryWrapper(ContactHistory conHistory,string Email1,string OldEmail1,string paramTitle)
                    {
                        
                         Datetime dt;
                            dt = Datetime.now();
                        DateOfAction = dt.format();
                        system.debug('Hello@@@'+DateOfAction);
                       //ContactHistoryId  = conHistory.Id;
                            this.Email = Email1;
                            this.oldEmail = OldEmail1; 
                            this.Title = paramTitle;
                        
                    }
              }
}