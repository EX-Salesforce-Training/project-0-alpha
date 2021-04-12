@isTest
public class CustomerTriggerHandlerTest {
    @isTest Public static void TestInsert() {
        Account currAccount = new Account(Name='Testing account');
        test.starttest();
        insert currAccount;
        test.stoptest();
        Account accInput = [SELECT Id, Name, Description FROM Account WHERE id = :currAccount.id];
        Task taskInput = [SELECT Id, Subject FROM Task WHERE whatId = :currAccount.id];
        system.assertEquals('Testing account', accInput.name);
        system.assertEquals('Book Store Corp. LLC', accInput.description);
    }
}
