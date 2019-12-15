public class LeadsCount
{
    public integer cntcount{get;set;}
    
    public LeadsCount()
    {
        list<lead> a=[select id from lead where createddate=today ];
        if(a.size()>0)
        {
            cntcount = a.size();
        }
        else
        {
            cntcount=0;
        }
    }
}