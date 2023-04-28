trigger bookValue on Yearly_Growth__c (before insert , before update) {
    Decimal prevBookValue = 0 ;
    
    for(Yearly_Growth__c yrg : Trigger.new){
         Id ProjId = yrg.Project__c;
        Project__c pro = [Select Id ,Lifetime__c, Initial_Investment__c from Project__c where Id = :ProjId];
        Decimal lifetime = pro.Lifetime__c;
        
       
        
        Decimal prevDepreciation = 5;
        Decimal yearNumber = 0;
        
        for(decimal i = 0 ; i <= lifetime ;i++){
            
            
            
            if(yrg.Year_Number__c == 0){
                yrg.Book_Value__c = 0;
            }
            
         
           else if(yrg.Year_Number__c == 1){
                
            yrg.Book_Value__c = pro.Initial_Investment__c;
                prevBookValue = yrg.Book_Value__c;
                yearNumber = yrg.Year_Number__c;
                pro.Previous_Book_Value__c = prevBookValue;
              //  prevDepreciation = yrg.Depreciation__c;
                System.debug('i===>>'+i);
                System.debug('prevBookValue===>>'+prevBookValue);
                System.debug('yearNumber===>>'+yearNumber);
            }
            
                
        
        else if(yrg.Year_Number__c > 1 && (yrg.Book_Value__c == null)){
            if(yrg.Year_Number__c == i){
                yrg.Book_Value__c = pro.Previous_Book_Value__c + 5;
                prevBookValue = yrg.Book_Value__c;
                pro.Previous_Book_Value__c = prevBookValue;
                 yearNumber = yrg.Year_Number__c;
                
                System.debug('Value of i===>>'+i);
                System.debug('value of prevBookValue===>>'+prevBookValue);
                System.debug('value of yearNumber===>>'+yearNumber);
            }         
                       
        }
        
    
        
        }
        
                
    }
}