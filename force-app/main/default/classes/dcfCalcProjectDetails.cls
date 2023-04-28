public with sharing class dcfCalcProjectDetails {
  @AuraEnabled(cacheable=true)
  public static DCF_Calculation__c dcfCalcProjectDetails(String dcfRecordId) {
    Project__c project = new Project__c();
    DCF_Calculation__c dcf = new DCF_Calculation__c();
    //dcf = [Select Id , Name from DCF_Calculation__c WHERE Project__c = ''];

    dcf = [
      SELECT
        Id,
        Name,Project__c,Project__r.Name,
        CurrencyIsoCode,
        Initial_Investment__c,Tax_Credit_Amount__c,Net_Investment__c,
        Opportunity_Cost__c,Initial_Investment_Amount__c,
        Lifetime__c,IP_Factor__c,
        Salvage_Value_at_end_of_project__c,
        Depreciation_Method__c,
        Other_invest_non_depreciable__c,
        Revenues_in_year_1__c,
        Var_Expenses_as_of_Rev__c,
        Fixed_expenses_in_year_1__c,
        IRR__c,ROC__c,
        Tax_rate_on_net_income__c,
        Tax_Credit__c,
        Discount_Rate_Approach__c,
        Discount_Rate__c,Initial_Investment_in_Working_Capital__c,Working_Capital_as_Percentage_of_Revenue__c,Salvageable_Fraction_At_End__c,
        Beta__c,Riskless_Rate__c,Market_Risk_Premium__c,Debt_Ratio__c,Discount_Rate_Used__c,Cost_Of_Borrowing__c
      FROM DCF_Calculation__c
      WHERE Id = :dcfRecordId
    ];
    return dcf;
  }

  @AuraEnabled(cacheable=true)
  public static List<WrapperClass> fetchYearlyGrowth(String dcfRecordId) {
    List<WrapperClass> wrapperYrg = new List<WrapperClass>();


    List<Yearly_Growth__c> yrg = [
      SELECT
        Id,
        Name,
        Revenue__c,Revenues__c,
        Fixed_Expenses__c,
        Year_Number__c,
        Equipment_Salvage_Value__c,
        Lifetime_Index__c,
        Variable_Expenses__c,
        Fixed_Expenses_Cashflow__c,
        EBITDA__c,
        Depreciation__c,
        EBIT__c,Working_Capital__c,
        EBIT_Without_Tax__c,
        NATCF__c,
        Discount_Factor__c,Discounted_CF__c,
        Tax__c,
        CurrencyIsoCode,
        Working_Capital_Salvage_Value__c,
        Book_Value_Beginning__c
      FROM Yearly_Growth__c
      WHERE DCF_Calculation__c = :dcfRecordId
      ORDER BY Year_Number__c
    ];

    for(Yearly_Growth__c y : yrg ){
    WrapperClass wrap = new WrapperClass();
     wrap.Id  = y.Id;
     wrap.Name = y.Name;
     wrap.Revenue = y.Revenue__c;
     wrap.Revenues = y.Revenues__c;
     wrap.FixedExpenses = y.Fixed_Expenses__c;
     wrap.YearNumber = y.Year_Number__c;
     wrap.EquipmentSalvageValue = y.Equipment_Salvage_Value__c;
     wrap.LifetimeIndex = y.Lifetime_Index__c;
     wrap.VariableExpenses = y.Variable_Expenses__c;
     wrap.FixedExpensesCashflow = y.Fixed_Expenses_Cashflow__c;
     wrap.EBITDA = y.EBITDA__c;
     wrap.Depreciation = y.Depreciation__c;
     wrap.EBIT = y.EBIT__c;
     wrap.EBITWithoutTax = y.EBIT_Without_Tax__c;
     wrap.NATCF = y.NATCF__c;
     wrap.workingcap = y.Working_Capital__c;
     wrap.DiscountFactor =  y.Discount_Factor__c;
     wrap.Tax =  y.Tax__c;
     wrap.isYear0 = false;
     wrap.CurrencyIsoCode = y.CurrencyIsoCode;
     wrap.WorkingCapitalSalvageValue = y.Working_Capital_Salvage_Value__c;
     wrap.BookValueBeginning = y.Book_Value_Beginning__c;
     wrap.discountedCf = y.Discounted_CF__c;
           
    wrapperYrg.add(wrap);
    }

    return wrapperYrg;
  }

  public class WrapperClass
    {
        @AuraEnabled
        public String CurrencyIsoCode;
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public Decimal Revenue;
        @AuraEnabled
        public Decimal BookValueBeginning;
        @AuraEnabled
        public Decimal Revenues;
        @AuraEnabled
        public Decimal FixedExpenses;
        @AuraEnabled
        public Decimal YearNumber;
        @AuraEnabled
        public Decimal EquipmentSalvageValue;
        @AuraEnabled
        public Decimal LifetimeIndex;
        @AuraEnabled
        public Decimal VariableExpenses;
        @AuraEnabled
        public Decimal FixedExpensesCashflow;
        @AuraEnabled
        public Decimal EBITDA;
        @AuraEnabled
        public Decimal Depreciation;
        @AuraEnabled
        public Decimal EBIT;
        @AuraEnabled
        public Decimal EBITWithoutTax;
        @AuraEnabled
        public Decimal NATCF;
        @AuraEnabled
        public Decimal DiscountFactor;
        @AuraEnabled
        public Decimal Tax;
        @AuraEnabled
        public Boolean  isYear0;  
        @AuraEnabled
        public Decimal WorkingCapitalSalvageValue;
        @AuraEnabled
        public Decimal workingcap;
        @AuraEnabled
        public Decimal discountedCf;
        

    }
}