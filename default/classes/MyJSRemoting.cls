global with sharing class MyJSRemoting
{
    public static Account account { get; set; }
     
    @RemoteAction
    global static Account getAccount(String accountName) {
        account = [select id, name, phone, type, numberofemployees from 
             Account where name = :accountName limit 1];
        return account;
    }   
}