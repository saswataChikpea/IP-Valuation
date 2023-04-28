public with sharing class iPDastboardController {
  @AuraEnabled(cacheable=true)
  public static Project__c projectDetails(String projectId) {
    List<Project__c> project = new List<Project__c>();
    project = [
      SELECT
        Id,
        Name,
        Portfolio__c,
        IP_Valuation__c,CurrencyIsoCode,
        Technology__c,Discount_Rate_Used__c,
        Description__c,
        Portfolio__r.Name,
        Portfolio__r.Portfolio_PFI__c,
        Portfolio__r.IP_Factor__c
      FROM Project__c
      WHERE Id = :projectId      
    ];
    return project[0];
  }

  // @AuraEnabled(cacheable=true)
  // public static IP_Valuation__c ipValuationDetails(String ipvaluationId) {
  //   List<IP_Valuation__c> ipValuation = new List<IP_Valuation__c>();
  //   ipValuation = [
  //     SELECT
  //       Id,
  //       Name,CurrencyIsoCode,
  //       Ip_Valuation_Total__c
  //     FROM IP_Valuation__c
  //     WHERE Id = :ipvaluationId
  //   ];
  //   return ipValuation[0];
  // }


  @AuraEnabled(cacheable=true)
  public static List<IP_Royalty__c> getIpRoyalties(String projectId) {
    List<IP_Royalty__c> royaltyList = new List<IP_Royalty__c>();
    royaltyList = [
      SELECT
        Id,
        Name,
        Royalty_Ratio_Low__c,
        Royalty_Ratio_High__c,
        Royalty_Max_Amount__c,
        Royalty_Min_Amount__c,
        Practice_Rate__c
      FROM IP_Royalty__c
      WHERE Project__c = :projectId
      
    ];

    return royaltyList;
  }

  @AuraEnabled(cacheable=true)
  public static List<Patent__c> getPatents(String projectId) {
   // List<IP_Valuation__c> ipValuationRec = new List<IP_Valuation__c>();
    List<Project__c> newProj = new List<Project__c>();
    Set<Id> portfolioSet = new Set<Id>();
    List<Portfolio__c> portfolioList = new List<Portfolio__c>();
    List<Portfolio__c> portfolioList2 = new List<Portfolio__c>();

    Map<Id, List<Patent_Portfolio__c>> portfolioMap = new Map<Id, List<Patent_Portfolio__c>>();
    List<Patent_Portfolio__c> patentPortfolio = new List<Patent_Portfolio__c>();
    List<Patent_Portfolio__c> patentPortfoliofinal = new List<Patent_Portfolio__c>();
    Map<Patent_Portfolio__c, Patent__c> patentMap = new Map<Patent_Portfolio__c, Patent__c>();
    List<Patent__c> PatentList = new List<Patent__c>();
    List<Patent__c> FinalPatentList = new List<Patent__c>();


    //ipValuationRec = [Select Id, Name from IP_Valuation__c WHERE Id = :ipValuationId];

    newProj = [
      SELECT Id, Name, Portfolio__c
      FROM Project__c WHERE Id = :projectId
       LIMIT 1
    ];
    system.debug('newProj' + newProj);

    for (Project__c proj : newProj) {
      portfolioSet.add(proj.Portfolio__c);
    }
    system.debug('portfolioSet' + portfolioSet);

    portfolioList = [
      SELECT Id, name
      FROM Portfolio__c
      WHERE Id IN :portfolioSet
    ];

    portfolioList2 = [
      SELECT
        Id,
        Name,
        (SELECT id, Name, Patent__r.Name FROM Patent_Portfolios__r)
      FROM Portfolio__c
      WHERE Id IN :portfolioList
    ];

    for (Portfolio__c port : portfolioList2) {
      portfolioMap.put(port.Id, port.Patent_Portfolios__r);
      // patentPortfolio.add(proj.Patent_Portfolios__r);
      for (List<Patent_Portfolio__c> p : portfolioMap.values()) {
        patentPortfolio.addAll(p);
      }
      system.debug('portfolioMap' + portfolioMap);
      system.debug('patentPortfolio' + patentPortfolio);
    }

    patentPortfoliofinal = [
      SELECT Id, Name, Patent__r.Name
      FROM Patent_Portfolio__c
      WHERE Id IN :patentPortfolio
    ];

    for (Patent_Portfolio__c p : patentPortfoliofinal) {
      patentMap.put(p, p.Patent__r);
    }

    for (Patent__c p : patentMap.values()) {
      PatentList.add(p);
    }

    FinalPatentList = [
      SELECT Id, Name, Patent_factor_Index__c
      FROM Patent__c
      WHERE Id IN :PatentList
    ];

    return FinalPatentList;
  }
}