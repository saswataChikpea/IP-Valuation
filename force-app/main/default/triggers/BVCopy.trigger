trigger BVCopy on Yearly_Growth__c (before update) {
    for(Yearly_Growth__c yrg : Trigger.New){
        if(yrg.Year_Number__c == 0){
            yrg.Copy_of_BV_Ending__c = yrg.Book_Value_Ending__c;
        }
    }
}