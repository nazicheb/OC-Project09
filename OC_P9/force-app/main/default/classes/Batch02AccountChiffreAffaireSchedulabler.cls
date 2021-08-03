global class Batch02AccountChiffreAffaireSchedulabler  implements Schedulable{
  
    global void execute(SchedulableContext SC) { 
        database.executeBatch(new Batch02AccountChiffreAffaire());
    }
    // To Shedule the execution of batch every week, just open Execute Anonymous Window in console develop and write: 
    // string timeinterval = '0 0 * ? * 7';
   //  System.schedule('BatchAccount-EveryWeek',timeinterval, new Batch02AccountChiffreAffaireSchedulabler());
   //  Then click execute 
}