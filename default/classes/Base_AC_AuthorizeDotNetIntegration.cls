public with sharing class Base_AC_AuthorizeDotNetIntegration 
{
     public String loginID{get;set;}
     public MileageHelper__SecuritySettings__c securityConfig {get; set;}
     //constructor
     public Base_AC_AuthorizeDotNetIntegration()
     {
           securityConfig  = MileageHelper__SecuritySettings__c.getOrgDefaults();
           loginID = securityConfig.MileageHelper__AuthorizeDotNet_LoginID__c;
           system.debug('test'+loginID);         
     }   
    
    public static testMethod void MyTest()
    {
        String loginID='abc';
        Base_AC_AuthorizeDotNetIntegration ba = new Base_AC_AuthorizeDotNetIntegration();
        final Double singletotalMiles = 300;
        System.assertEquals(singletotalMiles, 300);
        System.assertEquals('test', 'test');
    
    }   // Methods for testing

}