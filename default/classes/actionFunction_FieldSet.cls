//Controller class
public class actionFunction_FieldSet {

    
    public Account account {get;set;}
    public boolean noOfEmpReq {get;set;}
    public boolean BirthdateReq {get;set;}
    public String IsActive {get;set;}
    public Integer noofEmplyees {get;set;}
    public String currentDate {get;set;}
    public actionFunction_FieldSet()
        {
            noOfEmpReq  = false;
            account = new Account();
        }
    //action function to be called
    public void actionFunctionM()
        {
            currentDate = String.valueOf(system.today());
            if(IsActive == 'Yes Test' || noofEmplyees<= 10)
                //noOfEmpReq = true;
                BirthdateReq = true;
               
            else
                //noOfEmpReq = false; 
                
                BirthdateReq = false;                  
                
                 
        } 
      //action function to be called
    public void actionFunctionNumberofEmployees()
        {
            system.debug('testemployees'+noofEmplyees);
            if(noofEmplyees<= 10 || IsActive == 'Yes Test')
                BirthdateReq = true;
            else
                BirthdateReq = false;   
                 
        }
        public void actionFunctionCommon()
        {
                            
        }

}