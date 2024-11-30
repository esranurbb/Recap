public class OpportunityResellerTriggerHandler {
    public static void handleTrigger(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppsMap) {
        List<Opportunity> oppsToProcess = new List<Opportunity>();
        
        for (Opportunity opp : newOpps) {
            if (Trigger.isInsert || (Trigger.isUpdate && opp.Reseller__c != oldOppsMap.get(opp.Id).Reseller__c)) {
                if (String.isBlank(opp.Reseller__c) && String.isNotBlank(opp.Email__c)) {
                    oppsToProcess.add(opp);
                }
            }
        }
        
        if (!oppsToProcess.isEmpty()) {
            sendEmails(oppsToProcess);
        }
    }
    
    private static void sendEmails(List<Opportunity> opps) {
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        String EmailServiceMDT=[select Id, Email__c From EmailService__mdt Limit 1].Email__c;
        for (Opportunity opp : opps) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{opp.Email__c});
            email.setReplyTo(EmailServiceMDT);
            email.setSubject(opp.Name +'Request to Create Reseller Record');
            email.setPlainTextBody('Please create a reseller record for the opportunity: ' + opp.Name);
            emailsToSend.add(email);
        }
        
        if (!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
}