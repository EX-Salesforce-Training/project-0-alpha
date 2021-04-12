trigger CustomerTrigger on Account (before insert, after insert, after update) {
    // if(Trigger.isBefore && Trigger.isInsert) {
    //     CustomerTriggerHandler.handleBeforeInsert(Trigger.new);
    // } else if(Trigger.isAfter && Trigger.isInsert) {
    //     CustomerTriggerHandler.handleAfterInsert(Trigger.new);
    // }

    switch on trigger.operationType{
        when BEFORE_INSERT {
            CustomerTriggerHandler.HandleBeforeInsert(Trigger.new);
        }
        when AFTER_INSERT { 
            CustomerTriggerHandler.HandleAfterInsert(Trigger.new);
        }
        when AFTER_UPDATE {
            CustomerTriggerHandler.HandleAfterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
}