public class testPicklist
{
    public string ProfileId {get;set;}
    public testPicklist(){}//define constructor
    public List<selectOption> getUsers()
    {
        List<selectOption> options= new List<selectOption>();
        options.Add(new selectOption('','select user'));
        
        return options;
    }
    
}