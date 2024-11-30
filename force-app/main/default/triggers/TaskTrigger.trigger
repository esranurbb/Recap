trigger TaskTrigger on Task (after insert, after update, after delete, after undelete) {
    TaskTriggerHandler.updateOpportunityCompletedTaskField(Trigger.OperationType, Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap);

}