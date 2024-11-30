public with sharing class ContactTriggerHandler {
    public static void updateContactDescription(TriggerOperation triggertype, List<Contact> cTriggerNew) {
        if(triggertype == TriggerOperation.BEFORE_INSERT || triggertype == triggerOperation.BEFORE_UPDATE){
            for (Contact eachCon : cTriggerNew) {
                eachCon.Description = 'Automated by Trigger';
                
            }
        }
        
    }
}