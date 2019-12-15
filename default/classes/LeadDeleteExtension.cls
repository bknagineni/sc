public with sharing class LeadDeleteExtension {
    private Lead l;
    public LeadDeleteExtension(ApexPages.StandardController ctr) {
      l = [SELECT Id,name FROM Lead WHERE Id=:ctr.getRecord().Id];
    }
    public PageReference deleteLead() {
      // Check if the user has delete access on the Lead object
      if (!Lead.sObjectType.getDescribe().isDeletable()){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                                                    'Insufficient access')); 
        return null;
      }
      
      delete l;
      return null;
    }
    
     
}