trigger LeadTrigger on Lead (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    if(Trigger.isbefore && Trigger.isInsert){
        LeadAssignmentHelper.assignLeads(Trigger.new);
    }
}