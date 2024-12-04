global with sharing class TotalCostUpdate implements Database.Batchable<sObject>{
    public TotalCostUpdate() {

    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        /*return Database.getQueryLocator([
            SELECT ProjectC__c, SUM(Task_Cost__c) totalCost
            FROM TaskC__c
            GROUP BY ProjectC__c
        ]);*/
        return Database.getQueryLocator([
            SELECT ProjectC__c, Task_Cost__c
            FROM TaskC__c
            WHERE Task_Cost__c != NULL
        ]);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope){
        /*List<ProjectC__c> projectsToUpdate = new List<ProjectC__c>();
        for (sObject obj : scope) {

            AggregateResult result = (AggregateResult) obj;

            Id projectId = (Id) result.get('ProjectC__c');
            Decimal totalCost = (Decimal) result.get('totalCost');

            ProjectC__c project = new ProjectC__c(Id = projectId, Total_Cost__c = totalCost);
            projectsToUpdate.add(project);
        }

        if (!projectsToUpdate.isEmpty()) {
            update projectsToUpdate;
        }*/

        Map<Id, Decimal> projectCosts = new Map<Id, Decimal>();
        for (sObject obj : scope) {
            TaskC__c task = (TaskC__c) obj;
            if (task.ProjectC__c != null && task.Task_Cost__c != null) {
                if (!projectCosts.containsKey(task.ProjectC__c)) {
                    projectCosts.put(task.ProjectC__c, 0);
                }
                projectCosts.put(task.ProjectC__c, projectCosts.get(task.ProjectC__c) + task.Task_Cost__c);
            }
        }

        List<ProjectC__c> projectsToUpdate = new List<ProjectC__c>();
        for (Id projectId : projectCosts.keySet()) {
            ProjectC__c project = new ProjectC__c(Id = projectId, Total_Cost__c = projectCosts.get(projectId));
            projectsToUpdate.add(project);
        }

        if (!projectsToUpdate.isEmpty()) {
            update projectsToUpdate;
        }
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Batch Process Completed.');
    }
}