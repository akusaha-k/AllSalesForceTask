global with sharing class ContactCapitl implements Database.Batchable<sObject>{
    public ContactCapitl() {

    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, LastName From Contact');
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope){
        //List<Contact> conlist = new List<Contact>();
        for(Contact c : (List<Contact>) scope){
            c.LastName = c.LastName.toUpperCase();
            //conlist.add(c);
        }
        //Database.update conlist;
        Database.SaveResult[] results = Database.update(scope, false);
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Process Completed.');
    }
}