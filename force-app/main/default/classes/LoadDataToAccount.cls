global with sharing class LoadDataToAccount implements Database.Batchable<sObject>{
    public LoadDataToAccount() {

    }
    global Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id, Name From Account LIMIT 1');
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope){
        List<Account> acclist = new List<Account>();
        for(Integer i=0; i<200; i++){
            Account a = new Account();
            a.Name = 'Batch - ' + i+1;
            a.Site = 'www.acc/site'+i+'.com';
            a.Phone = '2349874'+i;
            acclist.add(a);
        }
        INSERT acclist;
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Batch Process Completed.');
    }
}