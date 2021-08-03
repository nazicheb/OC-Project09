public class AP01Order {

    public static void updateNetAmount(set<Id> setorderIds)
    {
       List<Order> orderList=new List<Order>();
       orderList=[Select Id,TotalAmount,NetAmount__c,ShipmentCost__c 
                  From Order
                  Where Id IN :setorderIds];
       
     //update of Net Amount of every Order based on the formula:Total Amount-Shipment Cost
       if(orderList!=null && orderList.size()>0)
       {
         for(Order ord:orderList)
         {
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
         }
         update orderList;
       }
    }
 }
