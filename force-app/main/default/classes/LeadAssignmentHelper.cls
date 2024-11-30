/*public class LeadAssignmentHelper {
    public static void assignLeads(List<Lead> leads) {
        
        Datetime now = System.now();
        Datetime adjustedNow = now.addHours(3);
        Time theTime = adjustedNow.time();
        
        // Query all shifts and filter them in Apex based on the adjusted current time
        List<Shift__c> allShifts = [
            SELECT Id, User__c, Start_Time__c, End_Time__c
            FROM Shift__c];
        
        // List to hold active shifts
        List<User> activeUser = new List<User>();
        List<User> allShiftUsers = new List<User>();
        
        // Filter shifts based on the current time and collect users
        for (Shift__c shift : allShifts) {
            User shiftUser = [SELECT Id FROM User WHERE Id = :shift.User__c AND IsActive = true LIMIT 1];
            allShiftUsers.add(shiftUser); // Collect all shift users
        
            if(shift.Start_Time__c <= theTime && shift.End_Time__c >= theTime){
                activeUser.add(shiftUser);
            }
        }
        
        // Assign each lead to the active user or a random user from all shift users if no active shifts
        for (Lead lead : leads) {
            if (activeUser.isEmpty()) {
                // Randomly select a user from all shift users
                Integer randomIndex = Integer.valueOf(Math.floor(Math.random() * allShiftUsers.size()));
                lead.OwnerId = allShiftUsers[randomIndex].Id;
            } else {
                // Assign to the first active user (if more than one, round-robin or other logic can be added)
                lead.OwnerId = activeUser[0].Id;
            }
        }
    }
}*/
public class LeadAssignmentHelper {
    public static void assignLeads(List<Lead> leads) {
        try {
            // Get current time
            Time currentTime = Datetime.now().time();
            System.debug('current time' + currentTime);
            
            // Fetch all shifts
            List<Shift__c> shifts = [SELECT Id, Start_Time__c, End_Time__c, User__c FROM Shift__c];
            System.debug('st' + shifts[0].Start_Time__c + 'et' + shifts[0].End_Time__c);
            System.debug('st' + shifts[1].Start_Time__c + 'et' + shifts[1].End_Time__c);
            System.debug('st' + shifts[2].Start_Time__c + 'et' + shifts[2].End_Time__c);
            System.debug('st' + shifts[3].Start_Time__c + 'et' + shifts[3].End_Time__c);
    
            // Iterate over each lead and assign to the correct representative
            for (Lead lead : leads) {
                for (Shift__c shift : shifts) {
                    
                    // Check if current time is within the shift's time range
                    if (currentTime >= shift.Start_Time__c && currentTime <= shift.End_Time__c) {
                        lead.OwnerId = shift.User__c;   
                        break;
                    }
                }
            }
            
        } catch (Exception ex) {
            // Log exception
            System.debug('Exception occurred at line ' + ex.getLineNumber() + ' due to ' + ex.getMessage());
        }
        
    }
    
}