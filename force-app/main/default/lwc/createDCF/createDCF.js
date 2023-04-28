import { LightningElement ,api, track} from 'lwc';
import DCF_OBJECT from '@salesforce/schema/DCF_Calculation__c';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateDCF extends NavigationMixin(LightningElement) {
    @api recordId;
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
    
    

    handleLifetime(event)
    {
        this.lifetime = event.target.value;
    }

    handleSuccess(event) {
        console.log('Record Created Id===>', event.detail.id);
        this.dcfId = event.detail.id;
        console.log('Lifetime',this.lifetime);
       this.singleAccount = false;

    //    this[NavigationMixin.Navigate]({
    //     type: 'standard__recordPage',
    //     attributes: {
    //         recordId: this.dcfId,
    //         actionName: 'view',
    //     },
    // })
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
                value: this.lifetime
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