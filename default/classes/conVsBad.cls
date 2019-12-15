public class conVsBad 
{
    Contact c;
    public Contact getContactMethod1() {
    if (c == null) c = [select id, name from contact limit 1];
        return c;
    }
    public Contact getContactMethod2() {
        return c;
    }
}