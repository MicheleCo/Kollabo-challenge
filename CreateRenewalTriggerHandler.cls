public with sharing class CreateRenewalTriggerHandler {


    public static void handleRenewal(List<Opportunity> opportunityList) {

        List<Opportunity> renewals = new List<Opportunity>();

        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Renewal').getRecordTypeId();

        Id accountId = [SELECT Id from Account WHERE Name LIKE '%Oil%' WITH SECURITY_ENFORCED order by CreatedDate desc LIMIT 1].Id;

        System.debug('recordTypeId: ' + recordTypeId);
        System.debug('accountId: ' + accountId);

        for (Opportunity opp : opportunityList) {
            // Only create renewal opps for closed won deals
            if (opp.StageName.contains('Closed')) {
               Opportunity renewal = new Opportunity();
               renewal.AccountId   = accountId;
               renewal.Name        = opp.Name + 'Renewal';
               renewal.CloseDate   = opp.CloseDate + 365; // Add a year
               renewal.StageName   = 'Open';
               renewal.RecordTypeId  = recordTypeId;
               renewal.OwnerId     = opp.OwnerId;
               renewals.add(renewal);
        }
      }

      // Bulk insert all renewals to avoid Governor Limits
      if (Opportunity.SObjectType.getDescribe().isCreateable()){
            insert renewals;
      }
    }


}