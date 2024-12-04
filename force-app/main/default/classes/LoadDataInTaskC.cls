
global with sharing class LoadDataInTaskC implements Database.Batchable<sObject>{
    public LoadDataInTaskC() {

    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Id, Task_Status__c, Due_Date__c
            FROM TaskC__c
            WHERE Task_Status__c != 'Completed'
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope){
        for(TaskC__c t : (List<TaskC__c>) scope){
            if(t.Due_Date__c != null && t.Due_Date__c <= Date.TODAY() && !t.Task_Status__c.equals('Completed')){
                t.Task_Status__c = 'Overdue';
            }
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Batch Process Completed.');
    }
}