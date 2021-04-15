trigger OrderBookTrigger on OrderBook__c  (before insert) {
    switch on trigger.operationType {
        when BEFORE_INSERT {
            OrderBookTriggerHandler.HandleBeforeInsert(Trigger.New);
        }
    }
}