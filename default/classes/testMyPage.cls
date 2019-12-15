public class testMyPage {

static testMethod void MyPage_Test()

{

//Test converage for the myPage visualforce page

PageReference pageRef = Page.MyPage;

Test.setCurrentPageReference(pageRef);

// create an instance of the controller

myPageController myPageCon = new myPageController();

//try calling methods/properties of the controller in all possible scenarios

// to get the best coverage.

Account pAccount = myPageCon.getAccount();

//test when type == null

myPageCon.viewAccounts();

//test when type = 'undefinedType'

pAccount.Type = 'other';

myPageCon.setAccount(pAccount);

myPageCon.viewAccounts();

// test when having results

pAccount.Type = 'Customer';

myPageCon.setAccount(pAccount);

myPageCon.viewAccounts();

myPageCon.getAccounts();

}

}