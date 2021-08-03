trigger orderTrigger on Order (after update) {
   if(trigger.isAfter)
    {
      //Retrieve only ordered Orders and then collect in a set all related account Ids  
       set<Id> setAccountIds = new set<Id>();
       for(Order ord:trigger.new){
         if(ord.Status=='Ordered')
         {
            if(ord.AccountId!=null)   setAccountIds.add(ord.AccountId); 
         }
           
       }  
     
       if(setAccountIds!=null && setAccountIds.size()>0)
            AP01Account.updateChiffreAffaire(setAccountIds);
    }
 }