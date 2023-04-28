trigger CopyPatent_PFI_to_CustomField on Patent_Portfolio__c (before insert , before update) {
    
    for(Patent_Portfolio__c port : trigger.new){
        if(port.Patent_PFI__c != null){
            port.Custom_Patent_PFI__c = port.Patent_PFI__c;
            
        }
    }

}