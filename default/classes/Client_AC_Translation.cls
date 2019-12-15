global class Client_AC_Translation
{
    global contact con{get;set;}
    global string str {get;set;}
    global string actualvalue {get;set;}
    global String arrTest {get;set;}
    global Client_AC_Translation()
    {
        str = 'testingpurpose:ending';
        String input = 'English-US';

           String strTest = 'Chinese (Simplified) - zh_CN';
           arrTest = strTest.split('\\-')[1];
    }
    
}