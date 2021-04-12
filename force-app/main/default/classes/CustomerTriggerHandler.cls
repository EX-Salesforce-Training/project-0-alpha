/*
// Name: CustomerTriggerHandler class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The customer trigger handler class will handle 
//              after insert and after update on the standard account object. 
*/

public class CustomerTriggerHandler {
   
   
    //Bussiness requirement: Taking two specific value fields from Account on update 
    //                       and update opportunity and contact records associated. 
    public static void HandleAfterUpdate(map<id, Account> oldRecords, map<id, Account> currRecords) {
        System.debug('starting handafterupdate');
        map<Id, Account> matchContacts = new map<Id, Account>();
        set<Id> availableContacts = new set<Id>();
        map<Id, Account> matchOpportunities = new map<Id, Account>();
        set<Id> availableOpportunities = new set<Id>();

        for(Account currAcc : currRecords.values()) { //To Store Customer record based on Opportunity 
            if(currAcc.Opportunity__c != null) {   //and Contact while updating
                availableOpportunities.add(currAcc.Opportunity__c);
                matchOpportunities.put(currAcc.Opportunity__c, currAcc);
            }
            if(currAcc.Contact__c != null) {
                availableContacts.add(currAcc.Contact__c);
                matchContacts.put(currAcc.Contact__c, currAcc);
            }
        }
        //store org Opportunities in collection
        //contacts are checked against existing customer accounts
        list <Opportunity> orgOpportunities = [SELECT Emergency_Contact_0__c, Emergency_Contact_1__c, Name, Id
                                           FROM Opportunity WHERE Id IN :availableOpportunities];
        list <Contact> orgContacts = [SELECT Emergency_Contact_0__c, Emergency_Contact_1__c, Name, Id
                                           FROM Contact WHERE Id IN :availableContacts];
        list <Contact> finalOrgContacts = new list<Contact>();
        for (Contact currContact : [SELECT Emergency_Contact_0__c, Emergency_Contact_1__c, Name, Id FROM Contact WHERE Id IN :availableContacts])
        { //Traverse new accounts and retreive both emergency contacts. 
            if(matchContacts.containsKey(currContact.Id)) {
                currContact.Emergency_Contact_1__c = matchContacts.get(currContact.Id).Emergency_Contact_1__c;
                currContact.Emergency_Contact_0__c = matchContacts.get(currContact.Id).Emergency_Contact_0__c;
                finalOrgContacts.add(currContact);
            }
        }
        list <Opportunity> finalOrgOpportunities = new list<Opportunity>();
        for (Opportunity currOpportunity : [SELECT Emergency_Contact_0__c, Emergency_Contact_1__c, Name, Id FROM Opportunity WHERE Id IN :availableOpportunities])
        { //Traverse new accounts and retreive both emergency contacts. 
            if(matchOpportunities.containsKey(currOpportunity.Id)) {
                currOpportunity.Emergency_Contact_1__c = matchOpportunities.get(currOpportunity.Id).Emergency_Contact_1__c;
                currOpportunity.Emergency_Contact_0__c = matchOpportunities.get(currOpportunity.Id).Emergency_Contact_0__c;
                finalOrgOpportunities.add(currOpportunity);
            }
        }
        if(finalOrgOpportunities.size() > 0) {
            update finalOrgOpportunities;
        }
        if(finalOrgContacts.size() > 0) {
            update finalOrgContacts;
        }
        
        
    }
}
