/*
// Name: CustomerTriggerHandlerTest class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The customer trigger handler Test class will handle 
//              any positive or negative testing needed for the "Account" standard object 
*/
@isTest
public class CustomerTriggerHandlerTest {
    
    @isTest Public static void TestHandleAfterUpdate() {
        //create account, opportunity and contact 
        Account testAccount = CustomerTriggerHandlerTest.GetNewAccount();
        test.starttest();
        insert testAccount;
        Contact testContact = CustomerTriggerHandlerTest.GetNewContact(testAccount.Id);
        Opportunity testOpportunity = CustomerTriggerHandlerTest.GetNewOpp(testAccount.Id);
        //check that all emergency contacts are consistent across all objects. 
        testAccount.Contact__c = testContact.Id;
        testAccount.Opportunity__c = testOpportunity.Id;
        insert testContact;
        insert testOpportunity;
        update testAccount;
        test.stoptest();

        System.assertEquals( testAccount.Emergency_Contact_0__c, testContact.Emergency_Contact_0__c);
        System.assertEquals( testAccount.Emergency_Contact_0__c, testContact.Emergency_Contact_1__c);
        System.assertEquals( testAccount.Emergency_Contact_1__c, testOpportunity.Emergency_Contact_0__c);
        System.assertEquals( testAccount.Emergency_Contact_1__c, testOpportunity.Emergency_Contact_1__c);

        Contact contCopy = [SELECT Id, Emergency_Contact_0__c, Emergency_Contact_1__c
                            FROM Contact 
                            WHERE Id = :testContact.Id];
        Opportunity oppCopy = [SELECT Id, Emergency_Contact_0__c, Emergency_Contact_1__c 
                               FROM Opportunity 
                               WHERE Id = :testOpportunity.Id];

        System.assertEquals( testAccount.Emergency_Contact_0__c, contCopy.Emergency_Contact_0__c);
        System.assertEquals( testAccount.Emergency_Contact_0__c, contCopy.Emergency_Contact_1__c);
        System.assertEquals( testAccount.Emergency_Contact_1__c, oppCopy.Emergency_Contact_0__c);
        System.assertEquals( testAccount.Emergency_Contact_1__c, oppCopy.Emergency_Contact_1__c);

   }
    //Create new Account for testing purposes
    public static Account GetNewAccount() 
    {
        Account currAccount =  new Account(Name='TestingGetnewAccount'); 
         return currAccount;
    }

    //Create new Opportunity for testing 
    public static Opportunity GetNewOpp(Id accId) {
         Opportunity currOpp = new Opportunity();
         currOpp.Name = 'test: TestHandleAfterUpdate GetNewOpp';
         currOpp.StageName = 'Prospecting';
         currOpp.AccountId = accId;
         currOpp.closeDate = Date.newInstance(2021, 4, 18);
         return currOpp;
    }
    //Create new Contact for testing 
    public static Contact GetNewContact(Id accId) {
        Contact currCont = new Contact();
       currCont.LastName = 'FalishaTest';
       currCont.AccountId = accId;
       return currCont;
   } 
   
}
