trigger orderItemTrigger on OrderItem (After insert) {

    if(trigger.isAfter)
    {
       //Retrieve in a set all Order Ids That are parent of inserted  order Items
       set<Id> setorderIds = new set<Id>();
       if(trigger.isInsert)
       {
         
         for(OrderItem ordItem:trigger.new)
         {
           setorderIds.add(ordItem.OrderId);
         }  
       }
       if(setorderIds!=null && setorderIds.size()>0)
            AP01Order.updateNetAmount(setorderIds);
    }
 
 }