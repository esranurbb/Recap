trigger ResellerTrigger on Reseller__c (before insert, before update, after insert, after update) {
    
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        ResellerInfoParserHandler.parseResellerInfo(trigger.new);
    }
}