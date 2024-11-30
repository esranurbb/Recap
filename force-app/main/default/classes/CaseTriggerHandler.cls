public with sharing class CaseTriggerHandler {
    public static void updateCaseDescription(TriggerOperation triggerType,  List<Case> cTriggerNew) {
        if(triggerType == TriggerOperation.BEFORE_INSERT){
            for (Case eachCase : cTriggerNew) {
                if(eachCase.Status == 'Working' && eachCase.Origin == 'Phone'){
                    eachCase.Description += ' A new case was created.';
                }

            }
        }
    }
}