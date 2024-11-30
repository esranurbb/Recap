public with sharing class PlayingWithDates {
    public void printDateOutput(){
        Date todaysDate = date.today();
        system.debug(todaysDate);

        Date date1 = date.newInstance(2785, 11, 5);
        system.debug(date1);

        Date date2 = date.newInstance(1987, 3, 5);
        system.debug(date2);

        integer dayInt = 5;
        integer monthInt = 10;
        integer yearInt = 1986;
        Date date3 = date.newInstance(yearInt, monthInt, dayInt);
        system.debug(date3);

        Date date4 = todaysDate.addDays(67);
        system.debug(date4);

        Date date5 = todaysDate.addMonths(-7);
        system.debug(date5);

        Date date6 = todaysDate.addDays(-896);
        system.debug(date6);

        Date date7 = todaysDate.addYears(-59);
        system.debug(date7);

        Date date8 = todaysDate.addYears(245);
        system.debug(date8);
    }
}