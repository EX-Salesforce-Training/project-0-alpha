///////////////////////////////////////////////////////////////
//
// Name: BookingApplicationTriggerHandler
// Author: David Serrano, Salesforce Trainee
// Created: 04/8/21
// Updated: 04/11/21
// Description: Trigger set up for Launch Detail records
//
///////////////////////////////////////////////////////////////

trigger LaunchDetailTrigger on Launch_Detail__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on trigger.operationType{
		when BEFORE_INSERT{ }
		when BEFORE_UPDATE{	}
		when BEFORE_DELETE{ }
		when AFTER_INSERT{ }
		when AFTER_UPDATE{ 
        	LaunchDetailTriggerHandler.UpdateStatus(trigger.new);
        }
		when AFTER_DELETE{ }
		when AFTER_UNDELETE{ }
	}
}