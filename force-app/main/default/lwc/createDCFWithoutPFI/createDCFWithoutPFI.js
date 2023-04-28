import { LightningElement,api,track,wire} from 'lwc';
import DCF_OBJECT from '@salesforce/schema/DCF_Calculation__c';
import createDCF from '@salesforce/apex/dcfWiithoutPFI.createDcf'

export default class CreateDCFWithoutPFI extends LightningElement {
    @api recordId;
    isCalled = true
    revenue;
    ltime;
    initial;
    Depre;
    TaxC;
    OtherInv;
    opporcost;
    VarExpe;
    DiscountRate;
    FixedExpe;
    Taxrate;
    Disrate;
    DebtR;
    costOfB;

    objectName = DCF_OBJECT;
    @track AccountName;
    @track stringData;
    @track StringAcc;
    @track remaining;
    @api isSaving = false;
    @track singleAccount = true;
    @track dcfId;
    @track lifetime;
    @track revenueInY1;
    checkedFlag=false;


    renderedCallback(){
        console.log('Connected callback called.');
        if(this.recordId && this.isCalled){
            this.isCalled=false
            console.log('Record ID:', this.recordId);
            createDCF({dcfRecordId : this.recordId})
            .then((res)=>{
                console.log("response==>",res);
                this.revenue=res[0].Revenues_in_year_1__c
                this.ltime=res[0].Lifetime__c
                this.initial=res[0].Initial_Investment__c
                this.Depre=res[0].Depreciation_Method__c
                this.TaxC=res[0].Tax_Credit__c
                this.OtherInv=res[0].Other_invest_non_depreciable__c
                this.opporcost=res[0].Opportunity_Cost_Rate__c
                this.VarExpe=res[0].Var_Expenses_as_of_Rev__c
                this.DiscountRate=res[0].Discount_Rate_Approach__c
                this.FixedExpe=res[0].Fixed_expenses_in_year_1__c
                this.Taxrate=res[0].Tax_rate_on_net_income__c
                this.Disrate=res[0].Discount_Rate__c
                this.DebtR=res[0].Debt_Ratio__c
                this.costOfB=res[0].Cost_Of_Borrowing__c
            })
        }
    }
    handleLifetime(event)
    {
        this.lifetime = event.target.value;
    }

    handleSuccess(event) {
        console.log('Record Created Id===>', event.detail.id);
        this.dcfId = event.detail.id;
        console.log('Lifetime',this.lifetime);
       this.singleAccount = false;
       console.log('singleAccount',this.singleAccount);
    }
    handleError(err){
        console.log("error"+err);
    }
    get inputVariables() {
        return [
            {
                name: 'DcfID',
                type: 'String',
                value: this.dcfId
            },
            {
                name: 'Lifetime',
                type: 'Number',
                value: this.ltime
            }, 
            {
                name: 'ProjectID',
                type: 'String',
                value: this.recordId
            },    
        ];
    }
    closeAction(event){
        var url = window.location.href; 
        var value = url.substr(0,url.lastIndexOf('/') + 1);
        window.history.back();
        console.log('url value'+value);
    }
   
}