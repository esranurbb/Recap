public with sharing class TaskTriggerHandler {
    public static void updateOpportunityCompletedTaskField(TriggerOperation triggerType, List<Task> tTriggerNew, List<Task> tTriggerOld, Map<Id, Task> tTriggerNewMap, Map<Id, Task> tTriggerOldMap) {
       
        Set<Id> opportunityIds = new Set<Id>();
    
        if (triggerType == system.TriggerOperation.AFTER_INSERT || triggerType == system.TriggerOperation.AFTER_UPDATE || TriggerType == system.TriggerOperation.AFTER_UNDELETE ) {
            for (Task task : tTriggerNew) {
                if (task.WhatId != null && task.WhatId.getSObjectType() == Opportunity.SObjectType) {
                    opportunityIds.add(task.WhatId);
                }
            }
        }
        
        if (TriggerType == system.TriggerOperation.AFTER_DELETE) {
            for (Task task : tTriggerOld) {
                if (task.WhatId != null && task.WhatId.getSObjectType() == Opportunity.SObjectType) {
                    opportunityIds.add(task.WhatId);
                }
            }
        }
        
        if (!opportunityIds.isEmpty()) {
            List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
            
            for (Opportunity opp : [SELECT Id, Completed_Tasks__c, Score__c,
                                    (SELECT Status, Cost__c FROM Tasks WHERE Status = 'Completed')
                                    FROM Opportunity
                                    WHERE Id IN :opportunityIds]) {
                                        

                Integer completedTaskCount = 0;
                Decimal taskScoreSum = 0;
                
                for (Task t : opp.Tasks) {
                    completedTaskCount++;

                       if (t.Cost__c != null) {
                        taskScoreSum += t.Cost__c;
                     }
                   }
                

            opp.Completed_Tasks__c = completedTaskCount;
            opp.Score__c = taskScoreSum;
                                                
            opportunitiesToUpdate.add(opp);
            }
                                            
            if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
            }
        }
    }
}