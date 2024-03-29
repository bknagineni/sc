/**
* @author Oliver Cortinas
* @createddate 04/29/2010
*/
public with sharing class ActionPlanTemplateDetailController {
	
	public ActionPlanTemplates		actionPlanTemplates	   { get; set; }
	public ActionPlanTemplate__c 	actionPlanTemplate	   { get; set; }
	public String           		actionPlanTemplateId   { get; set; }
	public Document                 actionPlanExportXMLDoc { get; set; }

	/**
     * Constructor
     * If we can obtain the Id from the page parameters then we search for that template and set the variable for that template.
     * If we can't obtain the Id from the page parameters then we create a new template and obtain from the controller.
     */
    public ActionPlanTemplateDetailController ( ApexPages.StandardController stdController ){
    	
        if( System.currentPageReference().getParameters().get( 'id' ) != null ){
        	
			this.actionPlanTemplateId 	= System.currentPageReference().getParameters().get( 'id' );
			this.actionPlanTemplate 	= [ select a.Id, a.Name, a.Description__c, a.SkipWeekends__c, a.SkipDay__c, a.LastModifiedDate, 
												a.LastModifiedBy.Name, a.LastModifiedById, a.CreatedDate, a.CreatedBy.Name, a.CreatedById, 
												a.Owner.Name from ActionPlanTemplate__c a
												Where a.Id =: this.actionPlanTemplateId limit 1 ];
		}
		else{
			this.actionPlanTemplate = ( ActionPlanTemplate__c ) stdController.getRecord();
		}
					
        this.actionPlanTemplates = new ActionPlanTemplates( this.actionPlanTemplate );
    }
	
	/**
	 * Call method deleteTemplate() insde the class ActionPlanTemplates
	 * @return PageReference
	 */
	public PageReference deleteTemplate(){
		return actionPlanTemplates.deleteTemplate();
	} 
	
	/**
	 * Call method getTemplateTasks() insde the class ActionPlanTemplates
	 * @return List<APTTaskTemplate__c>
	 */
	public List<APTTaskTemplate__c> getTemplateTasks(){
		return actionPlanTemplates.getTemplateTasks();
	}
	
	/**
	 * Call method getActionPlanTemplate() insde the class ActionPlanTemplates
	 * @return ActionPlanTemplate__c
	 */
	public ActionPlanTemplate__c getActionPlanTemplate() {
		return actionPlanTemplates.getActionPlanTemplate();
	}
	
	/**
	* Method exports the Action Plan template into a new XML document
	*/
	public void exportTemplateToXMLDoc(){
    	ExportActionPlanTemplate utility = new ExportActionPlanTemplate( this.actionPlanTemplateId );
    	
    	this.actionPlanExportXMLDoc = utility.export();
	}

	public static testMethod void testConstructor(){
    	
    	Test.StartTest();
    	
    	ActionPlansTestUtilities testUtil 	= new ActionPlansTestUtilities();
    	ActionPlanTemplate__c apTemplate 	= testUtil.createNewActionPlanTemplate( 2 );
    	
    	System.currentPageReference().getParameters().put( 'id', null );
    	ActionPlanTemplateDetailController apTemplateDetailController = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
    	
    	System.currentPageReference().getParameters().put( 'id', apTemplate.Id );
    	apTemplateDetailController = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
    	
    	Test.StopTest();
    }
    
    public static testMethod void testDeletActionPlanTemplate(){
    	
    	Test.StartTest();
    	
    	ActionPlansTestUtilities testUtil 	= new ActionPlansTestUtilities();
    	ActionPlanTemplate__c apTemplate 	= testUtil.createNewActionPlanTemplate( 2 );
    	
    	System.currentPageReference().getParameters().put( 'id', apTemplate.Id );
    	ActionPlanTemplateDetailController apTemplateDetailController = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
    	
    	apTemplateDetailController.deleteTemplate();
    	
    	List<ActionPlanTemplate__c> auxTemplate = [ select Id from ActionPlanTemplate__c where Id =: apTemplate.Id ];
    	
    	//Checks to see if action plan template has been deleted
    	System.assert( auxTemplate.isEmpty(), 'action plan Template was not deleted' );
    	
    	Test.StopTest();
    }
    
    public static testMethod void testRetrievingTemplateTasks(){
    	
    	Test.StartTest();
    	
    	ActionPlansTestUtilities testUtil 	= new ActionPlansTestUtilities();
    	ActionPlanTemplate__c apTemplate 	= testUtil.createNewActionPlanTemplate( 3 );
    	
    	System.currentPageReference().getParameters().put( 'id', apTemplate.Id );
    	ActionPlanTemplateDetailController apTemplateDetailController = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
    	
    	List<APTTaskTemplate__c> taskList = apTemplateDetailController.getTemplateTasks();
    	
    	//Checks to see if template tasks is not empty
    	System.assert( !taskList.isEmpty(), 'action plan Template tasks is empty' );
    	
    	//checks that list contains total number of created tasks
    	System.assertEquals( 3, taskList.size() );
    	
    	
    	Test.StopTest();
    }
    
    public static testMethod void testRetrievingActionPlanTemplate(){
    	
    	Test.StartTest();
    	
    	ActionPlansTestUtilities testUtil 	= new ActionPlansTestUtilities();
    	ActionPlanTemplate__c apTemplate 	= testUtil.createNewActionPlanTemplate( 3 );
    	
    	System.currentPageReference().getParameters().put( 'id', apTemplate.Id );
    	ActionPlanTemplateDetailController apTemplateDetailController = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
    	
    	ActionPlanTemplate__c apTemplate2 = apTemplateDetailController.getActionPlanTemplate();
    	
    	//Checks to see if action plan template is retrieved
    	System.assert( apTemplate2 != null, 'action plan Template tasks is empty' );
    	
    	//checks to see if both action plan templates are the same
    	System.assertEquals( apTemplate2.Id, apTemplate.Id  );
    	
    	Test.StopTest();
    }
    
    public static testmethod void exportTest(){
	
		Test.StartTest();
		
		ActionPlansTestUtilities testUtil = new ActionPlansTestUtilities();
		ActionPlanTemplate__c actionPlanTemplate = testUtil.createNewActionPlanTemplate( 3 );
		
		ActionPlanTemplateDetailController controller = new ActionPlanTemplateDetailController( new ApexPages.StandardController( new ActionPlanTemplate__c() ) );
		controller.actionPlanTemplateId = actionPlanTemplate.Id;
		
		controller.exportTemplateToXMLDoc();
		
		System.assert( controller.actionPlanExportXMLDoc != null ); 
		
		Test.StopTest();
	}
}