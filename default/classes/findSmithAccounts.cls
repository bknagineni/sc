public class findSmithAccounts {
private final List<Account> accounts;
public findSmithAccounts() {
accounts = [select Name from Account where Name LIKE '%test%'];
}
public List<Account> getSmithAccounts() {
return accounts;
}
public pageReference doEmail()
{
    return null;
}
}