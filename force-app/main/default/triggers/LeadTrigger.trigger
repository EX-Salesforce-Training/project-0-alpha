trigger LeadTrigger on Lead (before insert) {
    if (trigger.isBefore && trigger.isInsert) {
        list<Lead> lstLead = new List<Lead>();
        for (Lead l : lstLead) {
            
        }
    }
}