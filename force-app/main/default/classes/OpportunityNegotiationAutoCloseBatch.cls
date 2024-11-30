public with sharing class OpportunityNegotiationAutoCloseBatch implements Database.Batchable<sObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Id, Name, StageName, CloseDate 
            FROM Opportunity 
            WHERE StageName = 'Negotiation/Review' 
            AND CloseDate < :Date.today().addDays(-60)]);
    }
  
    public void execute(Database.BatchableContext bc, List<Opportunity> scope){
        for (Opportunity opp : scope) {
            opp.StageName = 'Closed';  
            opp.CloseDate = Date.today();
        }
        update scope;  
    }
  
    public void finish(Database.BatchableContext bc){
        Set<Id> userIds = new Set<Id>();
        for (GroupMember gm : [SELECT UserorGroupId FROM GroupMember WHERE Group.Name = 'Daily Job']) {
            userIds.add(gm.UserOrGroupId);
        }
       
        Set<String> emailAddresses = new Set<String>();

        for (User us : [SELECT Email FROM User WHERE IsActive = TRUE AND Id IN :userIds AND Email != NULL]) {
            emailAddresses.add(us.Email);
        } 
        
        if (!emailAddresses.isEmpty()) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();   
            mail.setSubject('Opportunity Closed');
            mail.setPlainTextBody('The stage of the opportunity which is at Negotiation/Review Stage more than 60 days was updated as Closed with todays date. You can check the Setup -> Apex Jobs.');
            mail.setHtmlBody('<p>The job is dones. You can check the Setup -> Apex Jobs.</p>');
            mail.setToAddresses(new List<String>(emailAddresses));
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mail});
        } else {
            System.debug('No valid email addresses found. Email not sent.');
        }
        
    }
}