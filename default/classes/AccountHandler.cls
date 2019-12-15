//trialhead
public class AccountHandler
{
   public static string insertNewAccount(string accname)
   {
       try
       {
       Account acc = new Account(name=accname);
       insert acc;
       system.debug('hello sfdx');
       system.debug('comment from git hub');
       return acc.Id;
       }
       catch(DMLException e){return e.getMessage();}
   }
}