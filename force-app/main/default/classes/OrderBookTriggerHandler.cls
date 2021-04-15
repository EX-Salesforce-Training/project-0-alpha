/*
// Name: OrderTriggerHandler class
// Author: Andreology
// Created: 04/08/21
// Updated: 04/10/21
// Description: The Order trigger handler class will handle 
//              before inserts needed for the standard object Order
*/
public class OrderBookTriggerHandler {
    //handleBefore insert will add a service fee cost to the total cost of an order for the book store services. 
     public static void HandleBeforeInsert(List<OrderBook__c> currOrders) {
        //create map for id to books and sets for order and book id's
        Map<Id, Decimal> idToBook = new Map<Id, Decimal>();
        Set<Id> bookIds = new Set<Id>();
        Set<Id> orderIds = new Set<Id>();

        //loop through current orders (BookOrders)
        for( OrderBook__c orderBookEntry : currOrders) {
          //store book ids in set and order id's in set
          bookIds.add(orderBookEntry.bookId__c);
          orderIds.add(orderBookEntry.Order__c);
        }

        List<Book__c> books = [SELECT Id, Price__c FROM Book__c WHERE Id IN :bookIds];
        List<Order> orders = [SELECT Id, Total_Cost__c FROM Order WHERE Id IN :orderIds];

        //create map of book id to price of book 
        for(Book__c b : books) {
            idToBook.put(b.Id, b.Price__c);
        }
        //traverse list of orders 
        for(OrderBook__c ob : currOrders) {
            for(Order o : orders) {
                //if price is not null and book hasn't been added to order 
                //set new price for order based on book found.
                if(o.Id == ob.Order__c) {
                    if (o.Total_Cost__c != null) {
                        o.Total_Cost__c += idToBook.get(ob.bookId__c);
                    }else {
                        o.Total_Cost__c = idToBook.get(ob.bookId__c);
                    }
                }
            }
        }
        if(orders != null) {
         update orders;
        }

    }
}
