trigger StudentAdvisorTrigger on Student__c (before insert, before update) {
    Set<String> studentMajors = new set<String>();
    for(Student__c std : Trigger.new) {
        if(std.Major__c != null) {
            studentMajors.add(std.Major__c);
        }
    } 
    Map<string, Advisor__c> advisorsMap = new Map<string, Advisor__c>();
    if (!studentMajors.isEmpty()){
        for(Advisor__c adv : [SELECT Id, Major__c FROM Advisor__c WHERE Major__c IN: studentMajors])
        advisorsMap.put(adv.Major__c, adv);
    }
    for(Student__c std : Trigger.new){
        if(studentMajors != null && advisorsMap.containsKey(std.Major__c)){
            std.Advisor__c = advisorsMap.get(std.Major__c).Id;

        }else{
            std.Advisor__c = null;
        }
    }
}