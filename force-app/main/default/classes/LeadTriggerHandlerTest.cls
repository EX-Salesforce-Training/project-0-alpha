@isTest
public class LeadTriggerHandlerTest {
    @isTest Public static void TestInsert() {
        Lead currLead = new Lead();
        currLead.Title='Testing account';
        test.starttest();
        insert currLead;
        test.stoptest();
        Lead leadInput = [SELECT Id, Title, Description FROM Lead WHERE id = :currLead.id];
        system.assertEquals('Testing account', leadInput.Title);
        system.assertEquals('Book Store Corp. LLC', leadInput.description);
    }
}
