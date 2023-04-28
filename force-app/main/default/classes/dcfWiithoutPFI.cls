public with sharing class dcfWiithoutPFI {
    public static Integer counter = 1;
    @AuraEnabled(cacheable=true)
    public static List<DCF_Calculation__c> createDcf(String dcfRecordId){
        List<DCF_Calculation__c> dcfList=new List<DCF_Calculation__c>();
        dcfList=[Select Revenues_in_year_1__c,Project__c,Lifetime__c,Initial_Investment__c,Depreciation_Method__c
                ,Tax_Credit__c,Other_invest_non_depreciable__c,DCF_With_PFI__c,Opportunity_Cost_Rate__c,Var_Expenses_as_of_Rev__c
                ,Discount_Rate_Approach__c,Fixed_expenses_in_year_1__c,Tax_rate_on_net_income__c,Discount_Rate__c
                ,Debt_Ratio__c,Cost_Of_Borrowing__c from DCF_Calculation__c where Project__c = :dcfRecordId and DCF_With_PFI__c=true limit 1];

        return dcfList;

    }
    // @InvocableMethod
    // public static List<Yearly_Growth__c> getRevenue(List<String> args){
        
    //     String dcfId = args[0];
    //     List<Yearly_Growth__c> yList = [select id,name,Year_Number__c,Revenue__c from Yearly_Growth__c where DCF_Calculation__r.DCF_With_PFI__c=true and project__c = :dcfId and Year_Number__c = :counter LIMIT 1];
    //     System.debug('yList'+yList);
    //     System.debug(' before counter'+counter);
    //     counter = counter+1;
    //     System.debug('counter'+counter);
    //     return yList;
    // }
}