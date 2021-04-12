///////////////////////////////////////////////////////////////
//
// Name: SpaceshipTrigger
// Author: David Serrano, Salesforce Trainee
// Created: 04/9/21
// Updated: 04/9/21
// Description: Trigger set up for Spaceship records
//
///////////////////////////////////////////////////////////////

trigger SpaceshipTrigger on Spaceship__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on trigger.operationType{
		when BEFORE_INSERT{ }
		when BEFORE_UPDATE{	}
		when BEFORE_DELETE{ }
		when AFTER_INSERT{ 
        	SpaceshipTriggerHandler.CreateSeats(trigger.new);
        }
		when AFTER_UPDATE{ }
		when AFTER_DELETE{ }
		when AFTER_UNDELETE{ }
	}
}
