trigger StudentTrigger on Student__c (before insert, before update, after insert, after update) {
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    StudentInfoParseHandler.ParseStudentInfo(trigger.new);
}
}