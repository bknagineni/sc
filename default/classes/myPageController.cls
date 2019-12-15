public class myPageController {

private Account acc = new Account();

private List<Account> accs;

public Account getAccount()

{

return acc;

}

public void setAccount(Account a)

{

acc = a;

}

public List<Account> getAccounts()

{

return accs;

}

public PageReference ViewAccounts()

{

if (acc.Type == null)

{

//view a message because validation has failed.

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Validation Failed: Select an item fron the dropdown list.'));

return null;

}

string AccountType = acc.Type;

accs = [Select id, name, type from Account where type= :AccountType limit 20];

if (accs == null || accs.size() == 0)

{

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No data found to be shown.'));

}

return null;

}

}