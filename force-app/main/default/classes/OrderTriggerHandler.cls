/*
// Name: OrderTriggerHandler class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The Order trigger handler class will handle 
//              before inserts needed for the standard object Order
*/
public class OrderTriggerHandler {
    //handleBefore insert will add a service fee cost to the total cost of an order for the book store services. 
     public static void HandleBeforeInsert(Set<Order> currOrders) {
        List<OrderBook__c> books = [SELECT BookId__c, order__c FROM OrderBook__c];
        Set<Id> bookIds = new Set<Id>();
        Map<Id, Decimal> idToBook = new Map<Id, Integer>();
        Map<Id, Integer> idToOrder = new Map<Id, Integer>();
        Set<Id> orderIds = new Set<Id>();
        //check books in junction object
        for (OrderBook__c  i : books ) {
            bookIds.add(i.bookId__c);
            orderIds.add(i.order__c);
        }
        
        List<Book__c> currentBooks = [SELECT Id, Price__c FROM Book__c WHERE Id IN :bookIds];

        for(Book__c i : currentBooks) {
            idToBook.put(i.Id, i.Price__c);
        }

        List<Order> myOrders = [SELECT Id, Name FROM Order WHERE Id NOT IN :orderIds];
        //take the outer join of the sets to get only
        //orders in junction table between Book and Order. i.e. BookOrder Table
        currOrders.removeAll(myOrders);
        for (Order i : currOrders) {
            if(i.Final_Cost__c == null) {
                for(OrderBook__c j : books) {
                        i.Final_Cost__c = idToBook.get(j.bookId__c);
                } 
            }
        }
    }
}
