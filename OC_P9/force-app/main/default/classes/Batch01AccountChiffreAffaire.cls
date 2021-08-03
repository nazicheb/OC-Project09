global class Batch01AccountChiffreAffaire implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([SELECT Id,(Select Id,Status,TotalAmount From Orders Where Status='Ordered') FROM Account]);
 
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){     
       
       //update of Chiffre d'affaire of every account based on total amounts of all its ordered orders
        for(Account myAcc:scope){
             myAcc.Chiffre_d_affaire__c = 0;
             for(Order ord:myAcc.Orders){
               if(ord.Status=='Ordered')
               {
                 myAcc.Chiffre_d_affaire__c = myAcc.Chiffre_d_affaire__c + ord.TotalAmount;
               }
             }
        }
        
        update scope;
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
 }
