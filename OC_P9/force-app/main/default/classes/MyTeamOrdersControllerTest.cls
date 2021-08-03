@isTest
public class MyTeamOrdersControllerTest {

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
         
        //Create orders
        Order ordTest1=new Order(AccountId=acc1.Id,Pricebook2Id=Test.getStandardPricebookId(),Status='Draft',EffectiveDate=System.Today()+7);
        insert ordTest1;
        
        Order ordTest2=new Order(AccountId=acc1.Id,Status='Draft',Pricebook2Id=Test.getStandardPricebookId(),EffectiveDate=System.Today()+14);
        insert ordTest2;
        
    }
    @isTest
    static  void fetchOrdersTest(){
       
       List<Order> ordList=[Select Id,Account.Name From Order Where Account.Name =: 'Test Account 1'];
       Test.startTest();
          MyTeamOrdersController.fetchOrders();
       Test.stopTest();
    }
    
    @isTest
    static  void SumOdersByOwnTest(){
      
       List<Order> ordList=[Select Id,Account.Name From Order Where Account.Name =: 'Test Account 1'];
       Test.startTest();
          MyTeamOrdersController.SumOdersByOwn();
       Test.stopTest();
        
    }
}
