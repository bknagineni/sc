public class FieldSetDescriber_Con {
    public String fieldset{get;set;}
    public FieldSetDescriber_Con(ApexPages.StandardController controller) {
        Map<String, String> reqParams = ApexPages.currentPage().getParameters();
        String sObjectName=reqParams.get('sObject');
        String fieldsetName =reqParams.get('sFieldSet');
        if(sObjectName==NULL || fieldsetName ==NULL || sObjectName.trim()==''|| fieldsetName.trim()==''){
            return;
        }
        else{
            fieldset= '{!$ObjectType.'+sObjectName+'.FieldSets.'+fieldsetName +'}';
        }
    }
    
    public Component.Apex.Repeat getContent(){
        if(fieldset!=null){
            Component.Apex.Repeat repeat =new Component.Apex.Repeat(var = 'field');
            repeat.expressions.value = fieldset;
            Component.Apex.OutputText outputText = new Component.Apex.OutputText();
            outputText.expressions.value = '{!field}';
            repeat.childComponents.add(outputText);
            outputText = new Component.Apex.OutputText(value=',');
            repeat.childComponents.add(outputText);
            return repeat;
        }
        else{
            return null;
        }
    }
    
}