trigger OrderTrigger on Order (before insert) {
    
    switch on trigger.operationType {
        when BEFORE_INSERT {
            OrderTriggerHandler.HandleBeforeInsert(Trigger.new);
        }
    }
}