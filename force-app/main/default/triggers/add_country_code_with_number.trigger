trigger add_country_code_with_number on Contact (before insert, before update) {
    List<Contact> conList = new List<Contact>();
    List<Contact> conList1 = new List<Contact>();
    for(Contact c : Trigger.new){
        conList.add(c);
    }
    if(Trigger.isInsert){
        addCountryCodeWithPhone.addTwoString(conList);
    }else if(Trigger.isUpdate){
        for(Contact c : Trigger.new){
            conList1.add(Trigger.oldMap.get(c.Id));
        }
        addCountryCodeWithPhone.forUpdating(conList, conList1);
    }
    
}