public with sharing class myPage_lifecycle_Controller {
private final Account account;
public myPage_lifecycle_Controller() {
account = [select id, name, site, NumberOfEmployees, Industry from Account
where id = :ApexPages.currentPage().getParameters().get('id')];
}
public Account getAccount() {
return account;
}
public PageReference save() {
update account;
return null;
}
public PageReference cancel() {
return null;
}
}