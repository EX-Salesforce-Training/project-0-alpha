/*
// Name: OrderBookTriggerHandlerTest class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The Order trigger handler test class will handle 
//              tests needed for the standard object Order
*/

@IsTest 
public with sharing class OrderBookTriggerHandlerTest {
        //testing method to check if OrderBook trigger handler is working right. i.e. positive test
        @isTest public static void  TestOrderHandler() {

            List<Id> orderIds = new List<Id>();
            Account randomAccount = OrderBookTriggerHandlerTest.GetNewAccount();
            Contract randomContract = OrderBookTriggerHandlerTest.GetNewContract( randomAccount.Id);
            Book__c randomBook = OrderBookTriggerHandlerTest.GetNewBook(0);
            Book__c randomBook_0 = OrderBookTriggerHandlerTest.GetNewBook(1);

            //begin testing where insert of new OrderBook should cause trigger to fire. 
            test.starttest();
            insert randomAccount;
            //create test orders and book to verify data entries
            insert randomBook;
            Order testOrder = OrderBookTriggerHandlerTest.GetNewOrder(randomContract.Id, randomAccount.Id, orderIds);
        
            insert testOrder;
            OrderBook__c orderBookEntryTest = OrderBookTriggerHandlerTest.GetNewOrderBook(randomBook.Id, testOrder.Id);
            OrderBook__c orderBookEntryTest_0 = OrderBookTriggerHandlerTest.GetNewOrderBook(randomBook.Id, testOrder.Id);
            insert orderBookEntryTest;
             insert orderBookEntryTest_0;
            test.stoptest();
            Order checkOrderIsUpdated = [SELECT Name, Id, Total_Cost__c FROM Order WHERE Id = :testOrder.Id];

            System.assertEquals( checkOrderIsUpdated.Total_Cost__c, 8);
        }
         
        //Create new OrderBook entry for testing purposes 
        public static OrderBook__c GetNewOrderBook(Id bookId, Id orderId) {
            OrderBook__c orderBookEntry = new OrderBook__c();
            orderBookEntry.Name = 'Testing OrderBook @ ' + bookId + ', '  + orderId;
            orderBookEntry.BookId__c = bookId;
            orderBookEntry.Order__c = orderId;
            return orderBookEntry;
        }

        //Create new Book for testing purposes
        public static Book__c GetNewBook(Integer x) {
            Book__c book = new Book__c();
            book.Name = 'Testing in OrderBookHandler test ' + x;
            book.Price__c = 4;
            return book;
        }
        //Create new Order for testing purposes
        public static  Order GetNewOrder(Id contractId, Id accountId, List<Id> orderIds) {
                Order curr = new Order();
                curr.Name = 'test@ ' + accountId;
                curr.ContractId =  contractId;
                curr.AccountId = accountId;
                curr.status = 'Draft';
                curr.EffectiveDate = Date.newInstance(2021, 4, 14);
                orderIds.add(curr.Id);
                return curr;
        }

        //Create new Account for testing purposes
        public static Account GetNewAccount() 
        { return new Account(Name='TestingGetnewAccount'); }

        //Create new Contract for testing purposes
        public static Contract GetNewContract(Id accId) { 
            Contract contract = new Contract();
            contract.AccountId = accId;
            contract.status = 'Draft';
            contract.contractTerm = 6;
            contract.startDate = Date.newInstance(2021, 4, 14);
            return contract;
        }
    }



