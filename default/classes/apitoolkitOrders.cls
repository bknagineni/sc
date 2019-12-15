public class apitoolkitOrders
{
     
    public String myresponse{get;set;}
    public String myresponse1{get;set;}
    public String myresponse2{get;set;}
    public String myresponse3{get;set;}
    /*public String ProfileName{get;set;}
    public String OrderName{get;set;}
    public String FirstName{get;set;}
    public String LastName{get;set;}
    public String Age{get;set;}
    public String Email{get;set;}
    public String Gender{get;set;}
    public String ReportType{get;set;}*/
    public boolean isdisplay{get;set;}
    //public apitoolkit responseForm{get;set;}
    public List<Orderwrap> olist{get;set;}
    public transient List<Orderdocwrap> odoclistwrapper{get;set;}
    public Order__c ord{get;set;}
    public string attachmentId ;
    public string orderinsId {get;set;}
    public String SelectedSubType{get;set;}
    public boolean isSubindividualtype {get;set;}
    public boolean isSubOrg{get;set;}
    public apitoolkitOrders()
    {
    isdisplay=false;
    //myresponse1=null;
    }
    public apitoolkitOrders(ApexPages.StandardController con)
    {
      //ord = (Order__c)con.getRecord();
      attachmentId = ApexPages.currentPage().getParameters().get('AttachmentId');
    } 
    //Call Tax id required
      public void setSubjRequired()
           {
               checkSubRequired(SelectedSubType);
           } 
       public void checkSubRequired(String SubType)
          {
                       
              if(SubType== 'Individual')
              {
                  isSubindividualtype = true;
                  isSubOrg= false;
              }
              else if (SubType== 'Organization')
              {
                  isSubindividualtype = false;
                  isSubOrg= true;

              }
           }
    public class Orderwrap {
        //Static Variables 
        public string OrderResultID{get;set;}
        public string OrderName{get;set;}
        public string FirstName{get;set;}
        public string LastName{get;set;}
        public string Message{get;set;}
        
        //Wrapper  Class Controller
        Orderwrap(string OrderId, string OrderName, string Result) {
            this.OrderResultID= OrderId;
            this.OrderName = OrderName;
            this.Message=Result;
        }
    }
    public class Orderdocwrap {
        //Static Variables 
        public string OrderName{get;set;}
        public string DocumentName{get;set;}
        public Blob content{get;set;}
        public string Message{get;set;}
        
        //Wrapper  Class Controller
        Orderdocwrap (string OrderName, string DocumentName,Blob content) {
            
            this.OrderName= OrderName;
            this.DocumentName= DocumentName;
            this.content=content;

        }
    }
   
    public Pagereference getOrder()
    {
        string endpoint='https://provide.castiron.ibmcloud.com/env/DevEnt1';
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        req.setEndpoint(endpoint+'/getaccount?id=0017E00000VLHgn');
        //req.setHeader('Authorization', 'OAuth '+accessToken);
        String username = 'testuser@cvmsolutions.com';
         String password = 'cvm101!!';
         Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
         req.setHeader('Authorization', authorizationHeader);
        
        HTTPResponse resp = http.send(req);
        myresponse=resp.getBody();          

        return null;    
        
    }
    
    
  
   public static List<Orderdocwrap> parsedoc(String str) 
   {
        //system.debug('*****str*****'+str );
        JSONParser parser = JSON.createParser(str);
        //system.debug('*****parse*****'+parser );
        List<Orderdocwrap> jsonstatLst = new List<Orderdocwrap> ();
        while (parser.nextToken() != null) { System.debug('Current token: ' +  parser.getCurrentToken() + '****JSONToken.START_ARRAY****'+JSONToken.START_ARRAY);
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    // Advance to the start object marker to
                    //  find next invoice statement object.
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        jsonstatLst.add((Orderdocwrap)parser.readValueAs(Orderdocwrap.class));
                        parser.skipChildren();
                    }
                }
            }
        }
        //system.debug('Hello@@JSON'+jsonstatLst);
        return jsonstatLst;
    } 
   
  
}