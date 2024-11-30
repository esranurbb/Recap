trigger AccountTrigger on Account (after insert) {
    AccountTriggerHandler.createContact(Trigger.New, Trigger.Old);
}