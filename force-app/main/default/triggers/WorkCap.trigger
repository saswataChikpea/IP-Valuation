trigger WorkCap on Yearly_Growth__c (before insert) {
    // List<Yearly_Growth__c> yrgList = new List<Yearly_Growth__c>();
    // List<Project__c> proj = new List<Project__c>();

    
    // List<Decimal > val = new List<Decimal>();

    // Decimal i=0;
    // for(Yearly_Growth__c yrg : Trigger.new){
    //     Id ProjId = yrg.Project__c;
    //     Project__c pro = [Select Id,Working_Capital_as_Percentage_of_Revenue__c,Initial_Investment_in_Working_Capital__c from Project__c where Id = :ProjId];
        

        // if(yrg.Year_Number__c == 1 ){
        //     yrg.Working_Capital__c = (pro.Working_Capital_as_Percentage_of_Revenue__c * yrg.Revenues_for_product_Year_1_to_5__c
        //                                 - pro.Initial_Investment_in_Working_Capital__c) * yrg.Lifetime_Index__c;
        // }
        // if(yrg.Year_Number__c == 2 ){
        //     yrg.Working_Capital__c=2;
        //     System.debug('yearly Growth '+yrg);
        // }

        

        
        
        // yrgList = [Select id , Working_Capital__c from Yearly_Growth__c where Project__c = :ProjId ];
        
        // for(Yearly_Growth__c y : yrgList){
        
        // if(yrg.Year_Number__c < 6 ){
        //        val.add( workCapPercent * y.Revenues_for_product_Year_1_to_5__c -  pro.Initial_Investment_in_Working_Capital__c);
        //     }
        //     else 
        //     {
        //         val.add( workCapPercent  * y.Revenues__c - pro.Initial_Investment_in_Working_Capital__c) ;
                
        //     }
          
        // }
        
        // Decimal sum =0;
        // Integer i = 0;
        // for(Yearly_Growth__c y : yrgList){
        
        //     y.Working_Capital__c = val[i] - sum;
        //     sum += y.Working_Capital__c;
        //     i++;
            
        
        // }
        
        
       
    }
  //  update yrgList;