public class AP01Account {
   
    public static void updateChiffreAffaire(set<Id> accSetId)
    {
     
      List<Account> accList = [SELECT Id, Chiffre_d_affaire__c,(Select Id,Status,TotalAmount From Orders)
                               FROM Account
                               WHERE Id IN : accSetId];
    
    //update of Chiffre d'affaire of every account based on total amounts of all its ordered orders
      if(accList!=null && accList.size()>0)
      {
          for(Account acc:accList)
          {
            Decimal totalAmountOrders=0;
            for(Order ord:acc.Orders)
            {
               if(ord.Status=='Ordered')  totalAmountOrders=totalAmountOrders+ord.TotalAmount;  
            }
            acc.Chiffre_d_affaire__c = totalAmountOrders; 
         }
          
          update accList;
      }
    }
 }
