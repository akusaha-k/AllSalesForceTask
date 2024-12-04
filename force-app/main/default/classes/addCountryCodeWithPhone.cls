public with sharing class addCountryCodeWithPhone {
    public addCountryCodeWithPhone() {

    }

    /*
        When insert add two field in Phone field
    */
    public static void addTwoString(List<Contact> conlist){
        //List<Contact> newConlist = new List<Contact>();
        for(Contact c : conlist){
            if (c.Country_Code__c != null && c.Phone != null) {
                 String cc = c.Country_Code__c; 
                 String phone = cc + c.Phone; 
                 c.Phone = phone; 
            }
        }
    }

    /*
        At the time of update trigger this function is called
    */
    public static void forUpdating(List<Contact> conlist1, List<Contact> conlist){
        //List<Contact> newConlist = new List<Contact>();
        for(Integer i=0; i<conlist.size(); i++){
            String cc = conlist[i].Country_Code__c; 
            if(conlist1[i].Phone.startswith('+')){
                String phone = conlist1[i].Phone.substring(cc.length(), conlist1[i].Phone.length());
                conlist1[i].Phone = conlist1[i].Country_Code__c + phone;
            }else{
                conlist1[i].Phone = conlist1[i].Country_Code__c + conlist1[i].Phone;
            }
            
        }
    }
}