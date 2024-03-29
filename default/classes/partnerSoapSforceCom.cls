//Generated by wsdl2apex

public class partnerSoapSforceCom {
    public class results_element {
        public partnerSoapSforceCom.UpsertResult[] result;
        private String[] result_type_info = new String[]{'result','urn:partner.soap.sforce.com',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:partner.soap.sforce.com','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class Error {
        public String[] fields;
        public String message;
        public String statusCode;
        private String[] fields_type_info = new String[]{'fields','urn:partner.soap.sforce.com',null,'0','-1','true'};
        private String[] message_type_info = new String[]{'message','urn:partner.soap.sforce.com',null,'1','1','false'};
        private String[] statusCode_type_info = new String[]{'statusCode','urn:partner.soap.sforce.com',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:partner.soap.sforce.com','true','false'};
        private String[] field_order_type_info = new String[]{'fields','message','statusCode'};
    }
    public class UpsertResult {
        public Boolean created;
        public partnerSoapSforceCom.Error[] errors;
        public String id;
        public Boolean success;
        private String[] created_type_info = new String[]{'created','urn:partner.soap.sforce.com',null,'1','1','false'};
        private String[] errors_type_info = new String[]{'errors','urn:partner.soap.sforce.com',null,'0','-1','false'};
        private String[] id_type_info = new String[]{'id','urn:partner.soap.sforce.com',null,'1','1','true'};
        private String[] success_type_info = new String[]{'success','urn:partner.soap.sforce.com',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:partner.soap.sforce.com','true','false'};
        private String[] field_order_type_info = new String[]{'created','errors','id','success'};
    }
}