global with sharing class BatchExample implements Database.Batchable<sObject>{
    public BatchExample() {

    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, Name From Account');
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope){
        for(Account acc : (List<Account>) scope){
            acc.Name = acc.Name.replaceAll('- Updated', '');
        }
        UPDATE scope;
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Process Completed.');
    }
}