public with sharing class ResellerInfoParserHandler {
public static void parseResellerInfo (List<Reseller__c> resellersList) {
    for (Reseller__c res : resellersList) {
        if(res.Info__c != null){
            List<String> infoParts = res.Info__c.split('?');

            if(infoParts.size() == 5){
                res.Phone__c = infoParts[0];
                res.Email__c = infoParts[1];
                res.Country__c = infoParts[2];
                res.Age__c = integer.valueOf(infoParts[3]);
                res.Questions__c = infoParts[4];
            }
        }
        
    }
}
}