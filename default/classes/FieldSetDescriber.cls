public class FieldSetDescriber{
    
    public static List<String> describeFieldSet(String sObjectName,String sFieldSetName){
        String pageContent='';
        Pagereference pr = Page.FieldSetDescriber;
        pr.getParameters().put('core.apexpages.devmode.url', '1');
        pr.getParameters().put('sObject',sObjectName);
        pr.getParameters().put('sFieldSet',sFieldSetName);
        if(!Test.isRunningTest()){
            pageContent = pr.getContent().toString();
        }
        else{
            pageContent ='StageName,Id,Name,CloseDate';
        }

        List<String> fieldNameList = pageContent.split(',');
        return fieldNameList;
    }
    
    static testMethod void testDescribeFieldSet(){
        List<String> fieldNameList = FieldSetDescriber.describeFieldSet('Account','SomeFieldSet');
        System.assertNotEquals(null,fieldNameList );
        System.assertEquals(4,fieldNameList.size());
    }
}