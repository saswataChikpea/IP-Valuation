trigger createTaskOnProject on DCF_Calculation__c (after insert) {
    Set<Id> projectId = new Set<Id>();
    for(DCF_Calculation__c dcf : trigger.new){
        if(dcf.DCF_With_PFI__c == true){
            Task t = new Task();
            t.Subject = 'DCF Calculation WITH PFI DONE Succesfully!';
            t.WhatId = dcf.Project__c;
            t.Status = 'Completed';
            insert t;
                
        }
        else if(dcf.DCF_With_PFI__c == false){
            Task t = new Task();
            t.Subject = 'DCF Calculation WITHOUT PFI DONE Succesfully!';
            t.WhatId = dcf.Project__c;
            t.Status = 'Completed';
            insert t;
                
        }
        
        
        
    }

}