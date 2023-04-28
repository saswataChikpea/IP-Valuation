import { LightningElement, track, api } from 'lwc';
import getIpRoyalties from '@salesforce/apex/iPDastboardController.getIpRoyalties';
import projectDetails from '@salesforce/apex/iPDastboardController.projectDetails';
import getPatents from '@salesforce/apex/iPDastboardController.getPatents';
import { NavigationMixin } from 'lightning/navigation';





export default class IPValueDasboard extends NavigationMixin(LightningElement) {

    @api recordId;
    @track project = {};
    @track portfolio = {};
    @track ipRoyalty;
    @track ipValuation;
    @track patents;
    @track patentPorts;
    @track IpValuationTotal;
    @track currency;
    @track total;

    loaded = false;





    renderedCallback() {
        if (this.loaded === false && this.recordId) {
          
            this.projectDetails();
            this.getIpRoyaltiesJS();
            this.getPatentsJS();
        }
    }
    projectDetails() {
        this.loaded = true;
        console.log('IP Valuation recordid',this.recordId);
        projectDetails({ projectId : this.recordId })
            
            .then(data => {

                if (data) {
                    this.project = data;
                    this.project.Id = data.Id;
                    this.project.Name = data.Name;
                    this.project.CurrencyIsoCode = data.CurrencyIsoCode;
                    this.project.IP_Valuation__c = data.IP_Valuation__c;
                    this.project.Technology__c = data.Technology__c;
                    this.portfolio = data.Portfolio__r
                    this.portfolio.Name = data.Portfolio__r.Name;
                    this.portfolio.Portfolio_PFI__c = data.Portfolio__r.Portfolio_PFI__c;
                }
                console.log('Project:  ' + JSON.stringify(data));


            })
            .catch(error => {
                console.log('Project error log----' + error);
                this.loaded = false;
            })
    }



    getIpRoyaltiesJS() {
        this.loaded = true;

        getIpRoyalties({ projectId: this.recordId })
            .then(data => {

                if (data) {
                    this.ipRoyalty = data;
                    this.ipRoyalty.Id = data.Id;
                    this.ipRoyalty.Name = data.Name;
                }
                console.log('Royalty :  ' + JSON.stringify(this.ipRoyalty));
            })
            .catch(error => {
                console.log('Royalty error log--->-' + error);
                this.loaded = false;
            })
    }


    // getIpValuationJS() {
    //     this.loaded = true;

    //     ipValuationDetails({ projectId: this.recordId })
    //         .then(data => {

    //             if (data) {
    //                 this.ipValuation = data;
    //                 this.ipValuation.Id = data.Id;
    //                 this.ipValuation.Name = data.Name;
    //                 this.IpValuationTotal = data.Ip_Valuation_Total__c;
    //                 this.currency =  data.CurrencyIsoCode;
    //             }
    //             console.log('Valuation :  ' + JSON.stringify(this.ipValuation));
    //             console.log('Valuation :  ' + JSON.stringify(this.ipValuation.NPV_with_PFI__c));
    //         })
    //         .catch(error => {
    //             console.log('Valuation error log--->-' + error);
    //             this.loaded = false;
    //         })
    // }


    getPatentsJS() {
        this.loaded = true;

        getPatents({ projectId: this.recordId })
            .then(data => {

                if (data) {
                    this.patents = data;
                    // this.patents.Id = data.Id;
                    //this.patents.Name = data.Name;
                    // this.patentPorts.Patent_Portfolios__r.Patent__r.Name = data.Patent_Portfolios__r.Patent__r.Name;
                    this.total = data.length;
                    console.log('total',this.total);
                }
                console.log('Patents :  ' + JSON.stringify(data));
                //  console.log('Patentports :  ' + JSON.stringify(this.patents.Name));
            })
            .catch(error => {
                console.log('error log-->>>' + error);
                this.loaded = false;
            })
    }


    navigateToProjectPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.project.Id,
                objectApiName: 'Project__c',
                actionName: 'view'
            }
        });
    }

}