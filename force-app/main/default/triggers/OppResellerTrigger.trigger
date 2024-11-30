trigger OppResellerTrigger on Opportunity (before insert, before update) {
    Set<String> opportunityEmails = new Set<String>();
    for (Opportunity opp : Trigger.new) {
        if (opp.Reseller_Email__c != null) {
            opportunityEmails.add(opp.Reseller_Email__c);
        }
    }
    Map<String, Reseller__c> resellerMap = new Map<String, Reseller__c>();
    if (!opportunityEmails.isEmpty()) {
        for (Reseller__c reseller : [SELECT Id, Email__c FROM Reseller__c WHERE Email__c IN :opportunityEmails]) {
            resellerMap.put(reseller.Email__c, reseller);
        }
    }
    for (Opportunity opp : Trigger.new) {
        if (opp.Reseller_Email__c != null && resellerMap.containsKey(opp.Reseller_Email__c)) {
            opp.Reseller__c = resellerMap.get(opp.Reseller_Email__c).Id;
        } else {
            opp.Reseller__c = null; // Clear the lookup field if no match is found
        }
    }
}