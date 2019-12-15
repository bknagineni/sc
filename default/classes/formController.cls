public class formController {

  public class MyObject {
    private String hiddenField = 'Lorem ipsum dolor';
    private String textdata;
    private List<String> arrayData = new List<String>{'value1', 'value2', 'value3', 'value4' };

    public String getTextData() { return textdata; }
    public void setTextData(String data) { textdata = data; }

    public String getWebsite() {
      if (textdata != null) {
        return '<ul><li>' + hiddenField +
              '</li><li> ' + textdata + '</li></ul>';
      } else { 
         return ''; 
      }
    }

    public String getHiddenField() { return hiddenField; }
    public void setHiddenField(String data) { hiddenField = data; }
    public List<String> getArrayData() { return arrayData; }
  }

  private myObject my_object;

  public MyObject getMyObject() {
    if (my_object == null) { my_object = new MyObject(); }
    return my_object;
  }
  public String handleSubmit() {
    return null;
  }
}