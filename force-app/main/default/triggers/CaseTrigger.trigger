trigger CaseTrigger on Case (before insert, after insert, before update, after update) {
    CaseTriggerHandler.updateCaseDescription(Trigger.operationType, Trigger.New);

}