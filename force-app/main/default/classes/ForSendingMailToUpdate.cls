global with sharing class ForSendingMailToUpdate implements Database.Batchable<sObject>, Database.Stateful{
    public ForSendingMailToUpdate() {

    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT ProjectC__c, Task_Cost__c, Task_Status__c
            FROM TaskC__c
            WHERE Task_Cost__c != NULL
        ]);
    }

    global Integer totalTask = 0;
    global Integer totalOverdue = 0;
    global Decimal totalCost = 0;
    global void execute(Database.BatchableContext bc, List<sObject> scope){
        Map<Id, Decimal> projectCosts = new Map<Id, Decimal>();
        for(sObject obj : scope){
            TaskC__c task = (TaskC__c) obj;
            totalTask++;
            if(task.Task_Status__c == 'Overdue'){
                totalOverdue++;
            }
            if (task.ProjectC__c != null && task.Task_Cost__c != null) {
                if (!projectCosts.containsKey(task.ProjectC__c)) {
                    projectCosts.put(task.ProjectC__c, 0);
                    totalCost++;
                }
                projectCosts.put(task.ProjectC__c, projectCosts.get(task.ProjectC__c) + task.Task_Cost__c);
            }
        }
    }

    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'akash.saha@bjitacademy.com' }); 
        email.setSubject('Batch Apex Processing Summary');
        email.setPlainTextBody( 'Total Tasks Processed: ' + totalTask + '\n' + 
                                'Total Tasks Overdue: ' + totalOverdue + '\n' + 
                                'Total Project Cost Updated: ' + totalCost ); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}