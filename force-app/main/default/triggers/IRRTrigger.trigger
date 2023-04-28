trigger IRRTrigger on DCF_Calculation__c(before update) {
  List<DCF_Calculation__c> dcfList = new List<DCF_Calculation__c>();
  List<Decimal> NatcfValue = new List<Decimal>();
  List<Yearly_Growth__c> ylist = new List<Yearly_Growth__c>();
  Double irr = 0;
  Id prId;
  Decimal lifetime;

  // for (DCF_Calculation__c nprj : Trigger.New) {
  //   prId = nprj.Id;
  // }
  // System.debug('prId'+prId);
  // dcfList = [SELECT Id, Lifetime__c FROM DCF_Calculation__c WHERE Id = :prId];

  // System.debug('dcfList'+dcfList);

  // // ylist = [
  // //   SELECT id, Name, NATCF__c, Year_Number__c
  // //   FROM Yearly_Growth__c
  // //   WHERE DCF_Calculation__c = :prId
   
  // // ];
  // System.debug('prId'+ylist);

  // for (DCF_Calculation__c dc : dcfList) {
  //   lifetime = dc.Lifetime__c;
  // }

    Set<ID> Dcfids = Trigger.newMap.keySet();
    dcfList = [select id,Lifetime__c from DCF_Calculation__c where id = :Dcfids];
    ylist=[Select id,Name,NATCF__c,Year_Number__c from Yearly_Growth__c where DCF_Calculation__c = :Dcfids ORDER BY Year_Number__c];

    for (Yearly_Growth__c y : ylist) {
      NatcfValue.add(y.NATCF__c);
      for (DCF_Calculation__c p : dcfList) {
        if (y.Year_Number__c == p.Lifetime__c) {
          irr = XIRRcalculation.calculateExcelIRR(NatcfValue);
        } else {
          System.debug('No irr calculation');
      }
    }
  }

  for (DCF_Calculation__c p : Trigger.New) {
    p.IRR__c = irr;
  }
  System.debug('Irr Value -->' + irr);
}