public class LeadTriggerHandler {
    public static void HandleBeforeInsert(List<Lead> currLeads) {
        
        for ( Lead i : currLeads) {
            i.description = 'Book Store Corp. LLC';
        }
    }
    public static void HandleAfterInsert(List<Lead> currLeads) {
        List<Task> customerTask = new List<Task>();
        for ( Lead i : currLeads) {
           Task currTask = new Task();
           currTask.ownerId = i.OwnerId;
           currTask.Subject = ' New Customer, yay!';
           currTask.Priority = 'Normal';
           currTask.whatId = i.id;
           customerTask.add(currTask);
        }
        Insert customerTask;
    }
}
