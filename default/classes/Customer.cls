public class Customer {
    public String aName {get; set;}
    public Integer aEmp {get; set;}
    public String aPhone {get; set;}
    public void saveNew(){
        Account aa = new Account(
            Name = aName,
            NumberOfEmployees = aEmp,
            Phone = aPhone
            
        );
       system.debug('Hello'+aName);     
           insert aa;
                 
    }
}