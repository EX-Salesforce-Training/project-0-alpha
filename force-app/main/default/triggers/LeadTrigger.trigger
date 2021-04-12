trigger LeadTrigger on Lead (before insert) {
    switch on trigger.operationType{
        when BEFORE_INSERT {
            LeadTriggerHandler.HandleBeforeInsert(Trigger.New);
        }
        when AFTER_INSERT { 
            LeadTriggerHandler.HandleAfterInsert(Trigger.New);
        }
    }
}