/**         
* @author Matias Menafra
* @createdate 04/29/2010
*/
public with sharing class ActionPlanDetailController{
    
    public ActionPlan__c            actionPlan      { get; set; }
    public ActionPlansUtilities     actionPlanUtil  { get; set; }
    public String                   actionPlanId    { get; set; }
    
    /**
    * Constructor
    */
    public ActionPlanDetailController( ApexPages.StandardController stdController ){
        
        this.actionPlan = ( ActionPlan__c ) stdController.getRecord();
        
        if( System.currentPageReference().getParameters().get( 'id' ) != null ){
            this.actionPlanId = System.currentPageReference().getParameters().get( 'id' );
            
             //Add your Custom object in the SOQL Query
            this.actionPlan = [ select a.Id, a.Name, a.CreatedById, a.StartDate__c, a.Action_Plan_Template__r.Name, 
                                    a.Action_Plan_Template__r.Id, a.Action_Plan_Template__c, a.Account__c, a.Contact__c, 
                                    a.Lead__c, a.Opportunity__c,a.MileageHelper__Department__c,  a.Contract__c, a.Case__c, a.Campaign__c ,
                                    a.SkipWeekends__c, a.SkipDay__c, a.Owner.Name, 
                                    a.CreatedDate, a.LastModifiedById, a.LastModifiedDate
                                    from ActionPlan__c a  
                                    Where a.Id =: this.actionPLanId limit 1 ];
        }
        
        this.actionPlanUtil = new ActionPlansUtilities( this.actionPlan );
    }
    
    /**
    * Deletes current actionplan
    */
    public Pagereference deletePlan(){
        
        return this.actionPlanUtil.deletePlan();
    }
    
    /**
    * Gets all tasks for a given ActionPlan
    */
    public List<APTaskTemplate__c> getTasks(){
        
        return this.actionPlanUtil.getTasks();
    }
    
    /**
    * Retrieves size of APT Template Tasks List.
    * @return apTasks
    */
    public Integer getTaskSize(){
        
        return this.actionPlanUtil.getTaskSize(); 
    }
    
    /**
    * Returns number of completed tasks
    */
    public Integer getCompleted(){
        
        return this.actionPlanUtil.getCompleted();
    }
    
    /**
    * Checks if Action Plan Template has been changed since the creation of the Action Plan.
    * @return Boolean
    */
    public Boolean getVersion(){
        
        return this.actionPlanUtil.getVersion();
    }
    
    public String getRelatedObjectName(){
        
        String objName='';
        
        if( this.actionPlan.Account__c != null ){
            Account a = [select Name from Account where id =: this.actionPlan.Account__c limit 1]; 
            objName = a.Name;   
        }
        else if( this.actionPlan.Campaign__c != null ){
            Campaign c = [select Name from Campaign where id =: this.actionPlan.Campaign__c limit 1];
            objName = c.Name;
        }
        else if( this.actionPlan.Case__c != null ){
            Case c = [select Subject, CaseNumber from Case where id =: this.actionPlan.Case__c limit 1];
            objName = (c.Subject != null) ?  c.CaseNumber + ': ' + c.Subject : c.CaseNumber; 
        }
        else if( this.actionPlan.Contact__c != null ){
            Contact c = [select FirstName, LastName from Contact where id =: this.actionPlan.Contact__c limit 1];
            objName = (c.FirstName != null) ? c.FirstName + ' ' + c.LastName : c.LastName;
        }
        else if( this.actionPlan.Contract__c != null ){
            Contract c = [select ContractNumber from Contract where id =: this.actionPlan.Contract__c limit 1];
            objName = 'Contract Number :'+ c.ContractNumber;
        }
        else if( this.actionPlan.Lead__c != null ){
            Lead l = [select FirstName, LastName, Company from Lead where id =: this.actionPlan.Lead__c limit 1];
            objName = (l.FirstName != null) ? l.FirstName + ' ' + l.LastName + ', ' + l.Company : l.LastName + ', ' + l.Company;
        }
        else if( this.actionPlan.Opportunity__c != null ){
            Opportunity o = [select Name from Opportunity where id =: this.actionPlan.Opportunity__c limit 1];
            objName = o.Name;
        }
        else if( this.actionPlan.MileageHelper__Department__c != null ){
            MileageHelper__Department__c o = [select Name from MileageHelper__Department__c where id =: this.actionPlan.MileageHelper__Department__c limit 1];
            objName = o.Name;
        }
        return objName;
    }
    
    public String getCreatedBy(){
        
        User u = [select Name from User where id =: actionPlan.CreatedById limit 1];
        return u.Name;
    }

    public String getLastModifiedBy(){
    
        User u = [select Name from User where id =: actionPlan.LastModifiedById limit 1];
        return u.Name;
    }

    public static testMethod void constructorTests(){
        
        Test.StartTest();
        
        System.currentPageReference().getParameters().put( 'id', null );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 1 );
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController2 = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );
        
        Test.StopTest();
    }
    
    public static testMethod void checkTasks(){
    
        Test.StartTest();
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 3 );
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        List<APTaskTemplate__c> apTasks = apDetailController.getTasks();
        
        //Checks to see that list of tasks is not empty
        System.assert( !apTasks.isEmpty(), 'task list is empty' );
        
        Test.StopTest();
    }
    
    public static testMethod void checkTaskSize(){
    
        Test.StartTest();
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 3 );
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        
        List<APTaskTemplate__c> apTasks = apDetailController.getTasks();
        Integer numTasks                = apDetailController.getTaskSize();
        
        //Checks to see that list of tasks is not empty
        System.assert( !apTasks.isEmpty(), 'task list is empty' );      
        
        //check that both methods return correct number of task objects
        System.assertEquals( numTasks, apTasks.size() );
        
        Test.StopTest();
    }
    
    public static testMethod void checkCompletedTasks(){
    
        Test.StartTest();
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 3 );
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        Integer completedTasks = apDetailController.getCompleted();
        
        //verifies number of completed tasks
        System.assertEquals( 0, completedTasks );
        
        Test.StopTest();
    }
    
    public static testMethod void checkActionPlanTemplateVersion(){
    
        Test.StartTest();
        
        ActionPlansTestUtilities testUtil   = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan            = testUtil.createNewActionPlan( 'accounts', 2 );
        ActionPlanTemplate__c apTemplate    = testUtil.createNewActionPlanTemplate( 2 );
        
        actionPlan.Action_Plan_Template__c = apTemplate.Id;
        update actionPlan;
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        boolean versionName = apDetailController.getVersion();
        
        //Checks if Action Plan Template has not been changed since the creation of the Action Plan.
        //System.assert( !versionName );        
        
        apTemplate.Name = 'new name';
        update apTemplate;
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( actionPlan ) );      
        versionName = apDetailController.getVersion();
        
        //Checks if Action Plan Template has been changed since the creation of the Action Plan.
        //System.assert( versionName ); 
        
        Test.StopTest();
    }
    
    public static testMethod void checkDeleteActionPlan(){
    
        Test.StartTest();
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 2 );
        
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController apDetailController = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) );      
        apDetailController.deletePlan();
        
        List<ActionPlan__c> actionPlanList = [ select Id from ActionPlan__c where Id =: actionPlan.Id limit 1];
        
        //Checks if Action Plan Template has been changed since the creation of the Action Plan.
        System.assert( actionPlanList.isEmpty(), 'Action Plan was not deleted' );       
        
        Test.StopTest();
    }
    
    public static testMethod void checkGetRelatedObjectName(){
        
        ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
        
        ActionPlan__c actionPlan = testUtil.createNewActionPlan( 'accounts', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        ActionPlanDetailController APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        String name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'campaigns', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'cases', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'contacts', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'contracts', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'leads', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
        
        actionPlan = testUtil.createNewActionPlan( 'opportunitys', 0 );
        System.currentPageReference().getParameters().put( 'id', actionPlan.Id );
        APDC = new ActionPlanDetailController( new ApexPages.StandardController( new ActionPlan__c() ) ); 
        name = APDC.getRelatedObjectName();
        System.assert(name != null);
    }
}