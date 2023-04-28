trigger CreateYearlyGrowthFromProject on Project__c(
  after insert,
  after update
) {
  // if (Trigger.IsInsert) {
  //   List<Yearly_Growth__c> growthList = new List<Yearly_Growth__c>();

  //   Decimal lifetime = 0;
  //   Decimal currentRev = 0;
  //   Decimal revenueInY1=0;
  //   for (Project__c proj : Trigger.New) {
  //     lifetime = proj.Lifetime__c;
  //     revenueInY1=proj.Revenues_in_year_1__c;

  //     Yearly_Growth__c yrg = new Yearly_Growth__c();
  //     yrg.Previous_Revenue__c = proj.Revenues_in_year_1__c;


  //     // for (Integer i = 1; i <= lifetime; i++) {
  //     //   Yearly_Growth__c yrg = new Yearly_Growth__c();
  //     //   if(i == 1){
  //     //     yrg.Previous_Revenue__c = proj.Revenues_in_year_1__c;
  //     //      currentRev = proj.Revenues_in_year_1__c;
  //     //      System.debug('currentRev'+currentRev);
  //     //   }
  //     //   else if(i>1){
  //     //   yrg.Previous_Revenue__c = currentRev;
  //     //   currentRev = yrg.Previous_Revenue__c;
  //     //   }

  //       growthList.add(yrg);
  //     }
  //     insert growthList;
  //     system.debug('growthList===>' + growthList);
  //     system.debug('lifetime===>' + lifetime);
  //   }
 

  // if (Trigger.isUpdate) {
  //   Decimal newlifetime;
  //   Decimal updatedLifetime;
  //   Decimal oldLifetime;

  //   Set<Id> projectId = new Set<Id>();
  //   for (Project__c proj : Trigger.New) {
  //     newlifetime = proj.Lifetime__c;
  //     projectId.add(proj.Id);

  //     Project__c oldproject = Trigger.oldMap.get(proj.Id);

  //     oldLifetime = oldproject.Lifetime__c;

  //     List<Yearly_Growth__c> existinggrowthList = [
  //       SELECT Id, Name
  //       FROM Yearly_Growth__c
  //       WHERE Project__c IN :projectId
  //     ];

  //     List<Yearly_Growth__c> newgrowthList = new List<Yearly_Growth__c>();

  //     if (proj.Lifetime__c != oldproject.Lifetime__c) {
  //       if(oldproject.Lifetime__c != null){
  //         updatedLifetime = proj.Lifetime__c - oldproject.Lifetime__c;
  //       }
  //       else {
  //         newLifetime = proj.Lifetime__c;
  //       }
        
  //     }

  //     for (Decimal i = (oldLifetime + 1); i <= newLifetime; i++) {
  //       Yearly_Growth__c yrg = new Yearly_Growth__c();
  //       yrg.Name = 'Year - ' + i;
  //       yrg.Project__c = proj.Id;
  //       newgrowthList.add(yrg);
  //     }
  //     insert newgrowthList;
  //     system.debug('newgrowthList===>' + newgrowthList);
  //     system.debug('newLifetime===>' + newLifetime);
  //   }
  // }
}