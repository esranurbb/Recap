/**
 * @description     :When an email is sent to Salesforce from any email address, a reseller account is created.
 * @author          :Alice Aksoy
 * @group           :
 * @last modified on:09.06.2024
 * @last modified by:Alicetx61@gmail.com
**/

public with sharing class ResellerEmailHandler implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        try {
            // create Reseller record
            Reseller__c reseller = createResellerFromEmail(email);
            insert reseller;
            
            // add attachment
            createAttachments(reseller.Id, email);
            
            result.success = true;
            System.debug('Reseller successfully created from email: ' + reseller.Id);
        } catch(Exception e) {
            result.success = false;
            result.message = 'Error processing email: ' + e.getMessage();
            System.debug('Error in ResellerEmailHandler: ' + e.getMessage() + '\n' + e.getStackTraceString());
        }
        
        return result;
    }
    
    private Reseller__c createResellerFromEmail(Messaging.InboundEmail email) {
        // check sender email and fint to related Account
        Id accountId;
        if(email.fromAddress != null) {
            List<Contact> contacts = [SELECT AccountId FROM Contact WHERE Email = :email.fromAddress LIMIT 1];
            if(!contacts.isEmpty()) {
                accountId = contacts[0].AccountId;
            }
        }
        
        return new Reseller__c(
            Name = email.subject != null ? email.subject : 'New Reseller from Email',
            Description__c = email.plainTextBody,
            Email__c = email.fromAddress,
            Registration_Date__c = Date.today(),
            Status__c = 'New',
            Account__c = accountId
        );
    }
    
    private void createAttachments(Id resellerId, Messaging.InboundEmail email) {
        List<Attachment> attachments = new List<Attachment>();
        
        // Binary attachments
        if(email.binaryAttachments != null) {
            for(Messaging.InboundEmail.BinaryAttachment binaryAtt : email.binaryAttachments) {
                attachments.add(new Attachment(
                    ParentId = resellerId,
                    Name = binaryAtt.fileName,
                    Body = binaryAtt.body
                ));
            }
        }
        
        // Text attachments
        if(email.textAttachments != null) {
            for(Messaging.InboundEmail.TextAttachment textAtt : email.textAttachments) {
                attachments.add(new Attachment(
                    ParentId = resellerId,
                    Name = textAtt.fileName,
                    Body = Blob.valueOf(textAtt.body)
                ));
            }
        }
        
        if(!attachments.isEmpty()) {
            insert attachments;
            System.debug('Attachments created: ' + attachments.size());
        }
    }
}