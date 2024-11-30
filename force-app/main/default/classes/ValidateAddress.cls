public with sharing class ValidateAddress {

    //Class Variables
    public void validateHomeAddress(){
        //Method Variables - by default private
        string houseName = 'Green House';
        string streetName = 'Washington';
        string cityName = 'Albany';
        string stateName = 'New York';
        string stateISOCode = 'NY';
        string countryName = 'United States';
        string countryISOCode = 'USA';

        integer streetNameLength = streetName.length();
        system.debug('Street name length is: ' + streetNameLength);

        boolean containsHome = streetName.contains(houseName);
        system.debug('Street name contains house name or not: ' + containsHome);

        boolean containsISOCode = streetName.contains(stateISOCode);
        system.debug('Street Name contains or not stateISOCode: ' + containsISOCode);

        string stateISOCodeUpper = stateISOCode.toUpperCase();
        system.debug('State ISOcode in uppercase: ' + stateISOCodeUpper);

        string countryISOCodeUpper = countryISOCode.toUpperCase();
        system.debug('Country ISOCode to upperxase: ' + countryISOCodeUpper);

        string countryNameUpper = countryName.toUpperCase();
        system.debug('Country name is Uopper: ' + countryNameUpper);

        string cityLower = cityName.toLowerCase();
        system.debug('City in Lowercase: ' + cityLower);

        string stateLower = stateName.toLowerCase();
        system.debug('State Name inlower: ' + stateLower);

        //Concatinate means --  Adding two or more strings togehter.

        string concatHouseAndStreet = houseName + ' ' + streetName;
        system.debug('House and street name together: ' + concatHouseAndStreet);
        

    }



    }