List<DeleteEvent> deletedEvents = [SELECT Id, CreatedDate, EventUUID, ObjectType, CreatedById 
                                    FROM DeleteEvent 
                                    WHERE CreatedDate = LAST_N_DAYS:7];
System.debug('Silinmiş kayıtların logları: ' + deletedEvents);
Database.undelete(deletedEvents);

//UndeleteAllObjectsDynamic.UndeleteAllObjects();