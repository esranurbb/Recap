public with sharing class Students {
    public string firstName;
    public string lastName;
    public integer classYear;
    public string major;

    public string generateReport(){
        system.debug('Report generated for ' + firstName + ' ' + lastName + ' of ' + classYear );
        return major;
    }
}