public class exampleCon {
String str='';


String uname;
public String getUsername() {
return uname;
}
public PageReference sayHello() {
uname = UserInfo.getName();
return null;
}
public void setState(String n) {
state = n;
}
public String getState() {
return state;
}
public PageReference methodOne() {
string response='test|test1';
List<string> resTrans = response.split('|');
            system.debug('resTrans.IndexOf[0]---'+resTrans[0]);
return null;
}
private String state = 'no';
}