public with sharing class PropertyUtility {
    public PropertyUtility() {

    }
    public static void newListedProperties(){
        List<Property__c> newPropList = [SELECT Name,Broker__c.Email__c,Days_On_Market__c
         FROM Property__c WHERE Days_On_Market__c <= 30];
        for (Property__c prop : newPropList) {
            String propEmail = 'Property Name: ' + prop.Name + ' Property Email: ' + prop.Broker__c.Email__c;
            system.debug(propEmail);
        }
    }
}