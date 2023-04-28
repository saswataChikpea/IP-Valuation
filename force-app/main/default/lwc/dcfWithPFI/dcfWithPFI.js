import { LightningElement , track, wire  ,api} from 'lwc';
import dcfCalcProjectDetails from '@salesforce/apex/dcfCalcProjectDetails.dcfCalcProjectDetails';
import fetchYearlyGrowth from '@salesforce/apex/dcfCalcProjectDetails.fetchYearlyGrowth';
import { NavigationMixin } from 'lightning/navigation';


export default class DcfWithPFI extends NavigationMixin (LightningElement) {

    
    @track InitialInv;
    @track Lifetime;
    @track DepreciationMethod;
    @track yearlyGrowth;
    @track yearlyGrowth1;
    @track npv;
    @track irr;
    @track roc;

    @track SvgEndofPrj;
    @track currencyType;
    @track TaxCredit;
    @track OtherInv;
    @track IntInvinWC;
    @track WCasPercRev;
    @track slvgFracAtTheEnd;
    @track revInYr1;
    @track varExpasPercofRev;
    @track fixedExpInYr1;
    @track taxRateOnNetInc;
    @track discrateApproach;
    @track discRate;
    @track beta;
    @track risklessRate;
    @track marketRiskPrem;
    @track debtRatio;
    @track discRateUsed;
    @track oppCost;
    @track yearlyGrowthString;
    @track Id;
    @track projName;
    @track dcfName;
    @track projId;
    @track record = {};
    @api recordId;
    
   
    @wire(dcfCalcProjectDetails, {dcfRecordId:'$recordId'})
    wiredAccount({ error, data }) {
        console.log('ID>>>>>>>>>>',this.recordId);
        if (data) {
            
            this.record = data;
            this.Id = this.record.Id;
            this.dcfName = this.record.Name;
            this.projId = this.record.Project__c;
            this.projName = this.record.Project__r.Name;
            this.InitialInv = this.record.Initial_Investment__c;
            this.newInv = this.record.Net_Investment__c;
            this.taxCreditAmnt = this.record.Tax_Credit_Amount__c;
            this.Lifetime = this.record.Lifetime__c;
            this.DepreciationMethod = this.record.Depreciation_Method__c;
            this.SvgEndofPrj = this.record.Salvage_Value_at_end_of_project__c;
            this.currencyType = this.record.CurrencyIsoCode;
            this.TaxCredit = this.record.Tax_Credit__c;
            this.ipFactor = this.record.IP_Factor__c;
            this.intInvamnt = this.record.Initial_Investment_Amount__c;
            this.oppCost = this.record.Opportunity_Cost__c;
            this.OtherInv = this.record.Other_invest_non_depreciable__c;
            this.IntInvinWC = this.record.Initial_Investment_in_Working_Capital__c;
            this.WCasPercRev = this.record.Working_Capital_as_Percentage_of_Revenue__c;
            this.slvgFracAtTheEnd = this.record.Salvageable_Fraction_At_End__c;
            this.revInYr1 = this.record.Revenues_in_year_1__c;
            this.varExpasPercofRev = this.record.Var_Expenses_as_of_Rev__c;
            this.fixedExpInYr1 = this.record.Fixed_expenses_in_year_1__c;
            this.taxRateOnNetInc = this.record.Tax_rate_on_net_income__c;
            this.discrateApproach = this.record.Discount_Rate_Approach__c;
            this.discRate = this.record.Discount_Rate__c;
            this.beta = this.record.Beta__c;
            this.risklessRate = this.record.Riskless_Rate__c;
            this.marketRiskPrem = this.record.Market_Risk_Premium__c;
            this.debtRatio = this.record.Debt_Ratio__c;
            this.discRateUsed = this.record.Discount_Rate_Used__c;
            this.costOfBorrowing = this.record.Cost_Of_Borrowing__c;
            this.npv = this.record.NPV__c;
            this.irr = this.record.IRR__c;
            this.roc = this.record.ROC__c;


            console.log('Data', this.record);         
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }


    @wire(fetchYearlyGrowth,{dcfRecordId:'$recordId'})
    yearlyGrowthData({ error, data }) {
        if (data) {
            this.yearlyGrowth = data;
 

            this.yearlyGrowthString = JSON.parse(JSON.stringify(this.yearlyGrowth));


            for (var i = 0; i < this.yearlyGrowthString.length; i++) { 
                if (this.yearlyGrowthString[i].YearNumber === 0) {
                   this.yearlyGrowthString[i].isYear0 = true;
                    console.log('Year 0==',this.yearlyGrowthString[i].isYear0);
                }
                else if (this.yearlyGrowthString[i].YearNumber > 0) {
                    this.yearlyGrowthString[i].isYear0 = false;
                    
             } 
               // alert(this.yearlyGrowth[i].Year_Number__c);
            }
            this.yearlyGrowth1 = this.yearlyGrowthString;
            console.log('Yearly growth===', JSON.stringify(this.yearlyGrowth1));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.yearlyGrowth = undefined;
        }
    }

    navigateToDCFPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.record.Id,
                objectApiName: 'DCF_Calculation__c',
                actionName: 'view'
            }
        });
        console.log('DCF Button ',this.record.Id);
        console.log('Project Button ',this.record.Project__c);
        
    }
    navigateToProjectPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.record.Project__c,
                objectApiName: 'Project__c',
                actionName: 'view'
            }
        });
    }
}