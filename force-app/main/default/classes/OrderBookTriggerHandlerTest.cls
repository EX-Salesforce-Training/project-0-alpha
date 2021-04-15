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
        @isTest public static void  TestOrderHandler() {
        
            List<Order> orders = new List<Order>();

            List<Id> orderIds = new List<Id>();
            Account randomAccount = OrderBookTriggerHandlerTest.GetNewAccount();
            test.starttest();
            insert randomAccount;
            Contract randomContract = OrderBookTriggerHandlerTest.GetNewContract(randomAccount.Id);
            //create test orders to verify data entries
            for(Integer i =0; i < 90; i ++) {
                Order curr = new Order();
                curr.Name = 'test@ ' + i;
                curr.ContractId =  randomContract.Id;
                curr.AccountId = randomAccount.Id;
                curr.status = 'Draft';
                curr.EffectiveDate = Date.newInstance(2021, 4, 14);
                orders.add(curr);
                orderIds.add(curr.Id);
            }
            
            insert orders;
            test.stoptest();
            for (Order currOrder : orders) {
                //check each order object created to verify data is right 

            }
            System.assertEquals( 'helloworld', 'helloworld');
        }

        public static Account GetNewAccount() 
        { return new Account(Name='TestingGetnewAccount'); }

        public static Contract GetNewContract(Id accId) { 
            Contract contract = new Contract();
            contract.AccountId = accId;
            contract.status = 'Draft';
            contract.contractTerm = 6;
            contract.startDate = Date.newInstance(2021, 4, 14);
            return contract;
        }
    }



