//version created by nbk
Global class AccountTriggerHelper
{
    public static void updateChildLocationMerge(List<Account> lstAccountOld) 
    { 
        list<MileageHelper__Account_Location__c> al = [select id,MileageHelper__Merge_Flag__c from MileageHelper__Account_Location__c where MileageHelper__b_Account_ID__c in:lstAccountOld];
        list<MileageHelper__Account_Location__c> lstalupdate = new list<MileageHelper__Account_Location__c>();
        for(MileageHelper__Account_Location__c aloc:al)
        {
            aloc.MileageHelper__Merge_Flag__c=true;
            lstalupdate.add(aloc);
        }
        update lstalupdate;//comment from 2nd file, assuming htat this is 2nd
    }
}
         //