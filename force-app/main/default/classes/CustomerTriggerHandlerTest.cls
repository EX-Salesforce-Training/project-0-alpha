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
        Account currAccount = new Account(Name='New Test');
        test.starttest();
        insert currAccount;
        test.stoptest();
        Account accInput = [SELECT Id, Name, Description FROM Account WHERE id = :currAccount.id];
        Task taskInput = [SELECT Id, Subject FROM Task WHERE whatId = :currAccount.id];
        system.assertEquals('New Test', accInput.name);
        system.assertEquals('Book Store Corp. LLC', accInput.description);
    }
}
