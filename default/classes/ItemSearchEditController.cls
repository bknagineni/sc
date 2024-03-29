public with sharing class ItemSearchEditController {
 
  private ApexPages.StandardController controller {get; set;}
  public List<Sample__c> searchResults {get;set;}
  public string searchText {get;set;}
  public string MyParameter {get;set;}
 
  // standard controller - could also just use custom controller
  public ItemSearchEditController (ApexPages.StandardController controller) 
  {
      MyParameter = ApexPages.currentPage().getParameters().get('accid');
      system.debug('@@Hello--->'+MyParameter);
  }
  
  // fired when the search button is clicked
  public PageReference search() {
    String qry = 'select id, name, Project_Name__c from Sample__c ' +
      'where name LIKE \'%'+searchText+'%\' order by name';
    searchResults = Database.query(qry);
    return null;
  }
  
 
  // fired when the save records button is clicked
  public PageReference save() {
 
    try {
      update searchResults;
    } Catch (DMLException e) {
      ApexPages.addMessages(e);
      return null;
    }
 
    return new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
  }
 
  // takes user back to main record
  public PageReference cancel() {
    return new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
  }
 
}