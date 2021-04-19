/*
// Name: Customer Trigger
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The customer trigger will generate a method based on 
//a specific DML event. 
*/
trigger CustomerTrigger on Account (before insert, after insert, after update) {
    // if(Trigger.isBefore && Trigger.isInsert) {
    //     CustomerTriggerHandler.handleBeforeInsert(Trigger.new);
    // } else if(Trigger.isAfter && Trigger.isInsert) {
    //     CustomerTriggerHandler.handleAfterInsert(Trigger.new);
    // }

    switch on trigger.operationType{
        when AFTER_UPDATE {
            CustomerTriggerHandler.HandleAfterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
}