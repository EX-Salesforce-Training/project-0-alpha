/*
// Name: LeadTriggerHandlerTest class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The Lead trigger handler class will handle 
//              tests needed for the standard object Lead
*/
@isTest
public class LeadTriggerHandlerTest {
    //This test ill check if the title and description are accurate and valid. 
    @isTest Public static void TestInsert() {
        Lead currLead = new Lead();
        currLead.Title='Testing account';
        currLead.LastName = 'testing lead';
        currLead.Company = 'testc corp';
        test.starttest();
        insert currLead;
        test.stoptest();
        //end test and check results
        Lead leadInput = [SELECT Id, Title, Description, OwnerId FROM Lead WHERE id = :currLead.id];
        system.assertEquals('Testing account', leadInput.Title);
        system.assertEquals('Book Store Corp. LLC', leadInput.description);
       // Task testTask = [SELECT Subject, Priority, ownerId
      //                   FROM Task  
        //                 WHERE whatId = :currLead.owner];
        
        
        //system.assertEquals(' New Customer, yay!', testTask.Subject);
        //system.assertEquals('Normal', testTask.Priority);
    }
}
