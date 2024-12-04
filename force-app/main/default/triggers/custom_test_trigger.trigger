trigger custom_test_trigger on Account (after insert) {
    List<Contact> newcontacts = new List<Contact>();

    for(Account acc : Trigger.new){
        Contact newContact = new Contact(
            FirstName = 'Default',
            LastName = acc.Name,
            AccountId = acc.Id
        );
        newcontacts.add(newContact);
    }
    if(!newcontacts.isEmpty()){
        insert newcontacts;
    }
}