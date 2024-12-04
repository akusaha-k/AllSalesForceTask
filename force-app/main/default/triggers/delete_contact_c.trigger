trigger delete_contact_c on Contact (after delete) {
    List<Contact> newContacts = new List<Contact>();
    for(Contact c : Trigger.old){
        Contact newc = new Contact(
            FirstName = 'newFirstName',
            LastName = c.LastName
        );
        newContacts.add(newc);
    }
    if(!newContacts.isEmpty()){
        insert newContacts;
    }
}