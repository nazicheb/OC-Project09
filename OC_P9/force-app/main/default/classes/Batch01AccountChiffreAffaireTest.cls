@isTest
public class Batch01AccountChiffreAffaireTest {
  @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i=0;i<20;i++) {
            accounts.add(new Account(name='Account '+i));
        }
        insert accounts;
        
        //Create the Product
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
        
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        
        //Create orders
        List<Order> orders = new List<Order>();
        for (Account acc:accounts) {
            orders.add(new Order(AccountId=acc.Id,Pricebook2Id=Test.getStandardPricebookId(),ShipmentCost__c=10,Status='Ordered',EffectiveDate=System.Today()+7));
        }
        insert orders;
        
        //Create order Items
        List<OrderItem> orderItems = new List<OrderItem>();
        for(Order ord:orders){
            orderItems.add(new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150));
        }
        insert orderItems;
    }
    
    @isTest
    static  void executeBatchtest(){
        
        Test.startTest();
           Batch01AccountChiffreAffaire acup=new Batch01AccountChiffreAffaire();
           Id batchId = Database.executeBatch(acup);
        Test.stopTest();
        
    }

}