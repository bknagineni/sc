public class userEditTEST {
    public static testMethod void testUserEdit() {
        //get a user that is not in a system admin profile
        User u = [SELECT Id, Name FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
        
        //create a reference to the Visualforce page
        PageReference editPage = Page.userEdit;
        Test.setCurrentPage(editPage);
                
        //populate the Visualforce page with the Id of the user from above
        ApexPages.currentPage().getParameters().put('id', u.Id);
        
        //create an instance of the controller extension as if editing the user's details
        ApexPages.StandardController sc = new ApexPages.standardController(u);
        userExtension ext = new userExtension(sc);
        
        //call the method for populuating the picklist
        List<selectOption> managerList = ext.getMgrs();
        sc.save();
    }
}