public with sharing class StudentInfoParseHandler {
public static void ParseStudentInfo(List<Student__c> studentsList) {
    for (Student__c std : studentsList) {
        if (std.info__c != null) {
            List<String> parsedInfo = std.info__c.split('¿');

            if(parsedInfo.size() == 5){
                std.Phone__c = parsedInfo[0];
                std.Email__c = parsedInfo[1];
                std.Country__c = parsedInfo[2];
                std.Age__c = integer.valueOf(parsedInfo[3]);
                std.Questions__c = parsedInfo[4];
                }

            }
            
        }
    }
}