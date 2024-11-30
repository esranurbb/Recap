public with sharing class DeleteRecycleBin {
    public DeleteRecycleBin() {
        List<DeleteEvent> deletedEvents = [SELECT Id
                                    FROM DeleteEvent
                            ];
System.debug('Silinmiş kayıtların logları: ' + deletedEvents);
Database.undelete(deletedEvents);

    }
}
//DeleteRecycleBin.DeleteRecycleBin();