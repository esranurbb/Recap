public with sharing class AccountTriggerHandler {
    public static void createContact(List<Account> aTriggerNew, List<Account> aTriggerOld) {

        if(aTriggerOld == null){

            List<Contact> contactsCreated = new List<Contact>();

            for (Account acc : aTriggerNew) {
                Contact con = new Contact();
                con.FirstName = 'Default';
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                con.Email = 'changes@gmail.com';
                contactsCreated.add(con);
            }
            if(!contactsCreated.isEmpty()){
                insert contactsCreated;
            }

        }
        
    }
}