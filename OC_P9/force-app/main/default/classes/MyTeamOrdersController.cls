public without sharing class MyTeamOrdersController {

    @AuraEnabled
    public static Map<string,decimal> SumOdersByOwn(){
        
        //Retrieve a Map of Order Owner (Key) and Sum of total Amount (Value) of orders that belongs to this owner 
        Map<string,decimal> SumOdersByOwn=new Map<string,decimal>();
        List<AggregateResult> groupedResults = [SELECT Owner.Name own, SUM(TotalAmount) total
                                              FROM Order
                                              Group By Owner.Name];
        for(AggregateResult agg:groupedResults) 
        {
          SumOdersByOwn.put((string) agg.get('own'),(decimal) agg.get('total'));

        }
        
        return SumOdersByOwn;

    }
    
    @AuraEnabled
    public static List<Order> fetchOrders()
    {
        //Fetch orders that exists in organization 
        List<Order> ordList=new List<Order>();
        ordList=[Select Id,OrderNumber,Account.Name,OwnerId,Owner.Name,TotalAmount,Status
                 From Order];
        
        return ordList;
    }
    
}
