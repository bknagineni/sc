global class SaveAccountDetails {

   //Insert Account
   
    WebService static Account createAccount(String AcctName) {
    Account acct = new Account();
    acct.Name = AcctName;
    //acct.AccountNumber = String.valueOf(info.AcctNumber);
    insert acct;
    return acct;
  }
 
        
}