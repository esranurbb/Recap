trigger ContactTrigger on Contact (before insert, before update, after insert, after update) {
    ContactTriggerHandler.updateContactDescription(Trigger.Operationtype, Trigger.New);
}