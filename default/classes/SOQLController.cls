public class SOQLController 
{
    public String name
    {
        get{return name;}
        set{name = value;}
    }
    public List<Sample__c> queryResult {get;set;}
    public PageReference query()
    {
        String qryName = '%' +name+ '%';
        //String qry = 'select id,name from Sample__c where (name like \'%'+name+'%\')';
        String qry = 'select id,name from Sample__c where (name like:qryNaME)';
        queryResult = Database.query(qry);
        return null;
    }
}