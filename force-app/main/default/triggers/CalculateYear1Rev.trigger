//doing this using flow - Create YRG - V36

trigger CalculateYear1Rev on Yearly_Growth__c (after insert,after update) {
    // Map<Yearly_Growth__c,Id> yrgMap = new Map<Yearly_Growth__c,Id>();
    // List<Project__c> projList = new List<Project__c>();

    
    // for(Yearly_Growth__c yrg : Trigger.New){
        
    //     if (yrg.Year_Number__c == 1)
    //     {
    //         yrgMap.put(yrg , yrg.Project__c);
    //         System.debug('yrgMap==>'+yrgMap);
    //     }
        
    //     projList = [Select Id, Name , Revenues_in_year_1__c from Project__c Where Id In :yrgMap.values()];
        
    //     for(Project__c  proj : projList){
    //         proj.Revenues_in_year_1__c = yrg.Revenues__c;            
    //         update proj;            
    //         System.debug('yrg.Revenues__c==>'+yrg.Revenues__c);
    //     }
    // }

}