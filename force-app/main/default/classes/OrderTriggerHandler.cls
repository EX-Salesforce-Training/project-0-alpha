public class OrderTriggerHandler {
     public static void HandleBeforeInsert(Set<Order> currOrders) {
        List<OrderBook__c> books = [SELECT BookId__c, order__c FROM OrderBook__c];
        Set<Id> bookIds = new Set<Id>();
        Map<Id, Decimal> idToBook = new Map<Id, Integer>();
        Map<Id, Integer> idToOrder = new Map<Id, Integer>();
        Set<Id> orderIds = new Set<Id>();

        for (OrderBook__c  i : books ) {
            bookIds.add(i.bookId__c);
            orderIds.add(i.order__c);
        }
        
        List<Book__c> currentBooks = [SELECT Id, Price__c FROM Book__c WHERE Id IN :bookIds];

        for(Book__c i : currentBooks) {
            idToBook.put(i.Id, i.Price__c);
        }

        List<Order> myOrders = [SELECT Id, Name FROM Order WHERE Id NOT IN :orderIds];
        
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
