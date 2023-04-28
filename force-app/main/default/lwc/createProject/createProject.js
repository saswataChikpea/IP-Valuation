import { LightningElement, api, track } from 'lwc';
import PROJECT_OBJECT from '@salesforce/schema/Project__c';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateProject extends NavigationMixin(LightningElement) {

    @api recordId;
    objectName = PROJECT_OBJECT;
    @track AccountName;
    @track stringData;
    @track StringAcc;
    @track remaining;
    @api isSaving = false;
    @track singleAccount = true;
    @track prjId;
    @track lifetime;
    @track revenueInY1;
    
    ShowBtn=true;
    
    handleSubmit(event) {
       // this.singleAccount = false; 
    }

    handleLifetime(event)
    {
        this.lifetime = event.target.value;
    }

    handleSuccess(event) {
        console.log('Record Created Id===>', event.detail.id);
        this.prjId = event.detail.id;
        console.log('Lifetime',this.lifetime);
       this.singleAccount = false;

       this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.prjId,
            actionName: 'view',
        },
    }) 
    }
    closeAction(event){
        var url = window.location.href; 
        var value = url.substr(0,url.lastIndexOf('/') + 1);
        window.history.back();
        console.log('url value'+value);
    }
}