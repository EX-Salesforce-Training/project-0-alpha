trigger OrderTrigger on Order (before insert) {
    
    switch on trigger.operationType {
        when BEFORE_INSERT {
            Set<Order> orders = new Set<Order>(Trigger.new);
            OrderTriggerHandler.HandleBeforeInsert(orders);
        }
    }
}