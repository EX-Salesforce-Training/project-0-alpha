///////////////////////////////////////////////////////////////
//
// Name: BookingApplicationTriggerHandler
// Author: David Serrano, Salesforce Trainee
// Created: 04/8/21
// Updated: 04/11/21
// Description: Trigger set up for Seat records
//
///////////////////////////////////////////////////////////////

trigger SeatTrigger on Seat__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on trigger.operationType{
		when BEFORE_INSERT{ 
        	SeatTriggerHandler.CheckSeatLimit(trigger.new);
        }
		when BEFORE_UPDATE{	}
		when BEFORE_DELETE{ }
		when AFTER_INSERT{ }
		when AFTER_UPDATE{ }
		when AFTER_DELETE{ }
		when AFTER_UNDELETE{ }
	}
}