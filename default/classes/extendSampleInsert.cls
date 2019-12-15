public with sharing class extendSampleInsert{
  public List<Sample__c> searchResults {get;set;}
  public string searchText {get;set;}
  public String res{get;set;}
  User u = new User();
  // standard controller - could also just use custom controller
  public extendSampleInsert(ApexPages.StandardController controller) { }
 
  // fired when the search button is clicked
  public PageReference search() {
    String qry = 'select id, name, Project_Name__c from Sample__c ' +
      'where name =:searchText';
    searchResults = Database.query(qry);
    if (searchResults.size()>0)
    {
        res = 'Record found';
    }
    else
    
    {res = 'no record found'+UserInfo.getUserName();}
    system.debug(Logginglevel.ERROR,'testingdebuglog'+res);
    return null;
  }
 
  //to write Test Method
   public extendSampleInsert () {}
    
    public static testMethod void testextendSampleInsert () {
        // Instantiate a new controller with all parameters in the page
        //SiteLoginController controller = new SiteLoginController ();
        extendSampleInsert controller = new extendSampleInsert();
        controller.searchText = 'Tier2';
        controller.res = 'Record found';
        //controller.username = 'provisioning@17trialforce.com';
        //controller.password = 'CVMAdmin1033!!'; 
        System.assertEquals(controller.search(),null);
        //System.assertEquals(controller.login(),null);                           
    }    

 
  // fired when the save records button is clicked
 }