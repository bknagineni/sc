public class extendArrayController
{

    public extendArrayController(ApexPages.StandardSetController controller) {

    }

    private List<Candidate__c> can;
    public List<Candidate__c> getCandidates()
    {
        can = [select id,name from Candidate__c];
        return can;
    }
}