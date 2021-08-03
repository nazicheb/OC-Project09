@isTest
public class AP01OrderTest {

    @testsetup
    static void prepareDataForTest()
    {
        
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;
        
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
        
        //Create  orders
        Order ordTest1=new Order(AccountId=acc1.Id,Pricebook2Id=Test.getStandardPricebookId(),ShipmentCost__c=10,Status='Draft',EffectiveDate=System.Today()+7);
        insert ordTest1;
        
        Order ordTest2=new Order(AccountId=acc1.Id,Status='Draft',Pricebook2Id=Test.getStandardPricebookId(),ShipmentCost__c=10,EffectiveDate=System.Today()+14);
        insert ordTest2; 
        
        //Create  orderItems
        OrderItem ordItem1 = new OrderItem (OrderId = ordTest1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert ordItem1;
        
       OrderItem ordItem2 = new OrderItem (OrderId = ordTest2.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
       insert ordItem2; 
    }
    
    @isTest
    static  void updateNetAmountTest(){
        
        set<Id> OrdIdSet=new set<Id>();
        List<Order> ordList=[Select Id,Account.Name From Order Where Account.Name =: 'Test Account 1'];
        for(Order ord:ordList)
        {
            OrdIdSet.add(ord.Id);
        }
        
        Test.startTest();
           AP01Order.updateNetAmount(OrdIdSet);
        Test.stopTest();
    }
}