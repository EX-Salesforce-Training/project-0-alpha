/*
// Name: LeadTriggerHandler class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The Lead trigger handler class will handle 
//              before insert and after update on the standard Lead object. 
*/
public class LeadTriggerHandler {
    public static void HandleBeforeInsert(List<Lead> currLeads) {
        
        for ( Lead i : currLeads) {
            i.description = 'Book Store Corp. LLC';
        }
    }
    //Method to add a task to an account 
    //that is made in the org so the bookstore can track
   // public static void HandleAfterInsert(List<Lead> currLeads) {
    //    List<Task> customerTask = new List<Task>();
   //     for ( Lead i : currLeads) { //set new task
    //       Task currTask = new Task();
    //       currTask.ownerId = i.OwnerId;
    //       currTask.Subject = 'New Customer, yay!';
    //       currTask.Priority = 'Normal';
     //      currTask.whatId = i.id;
     //      customerTask.add(currTask);
     //   }
     //   Insert customerTask;
    //}
}
