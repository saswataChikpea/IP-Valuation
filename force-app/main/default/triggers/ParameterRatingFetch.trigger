trigger ParameterRatingFetch on Patent_Parameter__c (before insert , before update) {
    
    Set<Id> paramId = new Set<Id>();
    for(Patent_Parameter__c par: trigger.new){
        paramId.add(par.Id);
    } 	
    Map<Id, Patent_Parameter__c> tobeUpdated = new Map<Id,Patent_Parameter__c>([select id,name, Parameter__r.High_Rating_Explanation__c ,Parameter__r.Low_Rating_Explanation__c from Patent_Parameter__c where id in :paramId]);        
    for(Patent_Parameter__c par: trigger.new){
        if(par.Rating__c == NULL){
             Patent_Parameter__c queryMember = tobeUpdated.get(par.id);
        if(par.Rating__c> 3){
            par.Rating_Explanation__c = queryMember.Parameter__r.High_Rating_Explanation__c;
            system.debug('queryMember.High_Rating_Explanation__c'+queryMember.Parameter__r.High_Rating_Explanation__c);
        }
        else{
            
                par.Rating_Explanation__c = queryMember.Parameter__r.Low_Rating_Explanation__c;
            }
                        

        }
            
           
           
        
    } 
    

    
    
    

}