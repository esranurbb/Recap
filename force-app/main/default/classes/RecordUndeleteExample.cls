public with sharing class RecordUndeleteExample {
    public static void undeleteAccounts() {
        // Recycle Bin'deki silinmiş kayıtları sorgulama
        List<Account> deletedAccounts = [SELECT Id, Name, SystemModstamp FROM Account WHERE IsDeleted = true ALL ROWS];

        if (!deletedAccounts.isEmpty()) {
            try {
                // Silinmiş kayıtları geri yükleme
                Database.undelete(deletedAccounts, false);
                System.debug('Deleted records have been restored.');
            } catch (Exception e) {
                System.debug('Error occurred while undeleting records: ' + e.getMessage());
            }
        } else {
            System.debug('No deleted records found in the Recycle Bin.');
        }
    }
}
//RecordUndeleteExample.undeleteAccounts();