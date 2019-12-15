/**
 * An apex page controller that exposes the site login functionality
 */
global class SiteLoginController {
    global String username {get; set;}
    global String password {get; set;}
    

    global PageReference login() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        system.debug('testlogin'+startUrl);
        PageReference startPage;  
        //return Site.login(username, password, startUrl);
        if(username=='') 
        { 
            ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, '没有用户名')); 
            return null;
        } 
        if(password=='' && username!='') 
        { 
            ApexPages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, 'testing method')); 
        } 
        startPage= Site.login(username, password, '/apex/helloworld');
        return startPage;
         
    }
    
    global SiteLoginController () {}
    
    global static testMethod void testSiteLoginController () {
        // Instantiate a new controller with all parameters in the page
        SiteLoginController controller = new SiteLoginController ();
        controller.username = 'test@salesforce.com';
        controller.password = '123456'; 
                
        System.assertEquals(controller.login(),null);                           
    }    
}