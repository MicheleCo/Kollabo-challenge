
trigger CreateRenewal on Opportunity (before update) {


      Map<Id, Opportunity> renewals = new Map<Id, Opportunity>();

      for (Opportunity opp : Trigger.new) {  // logic should be avoided in trigger

        if (opp.StageName.contains('Closed')) {
           Opportunity renewal = new Opportunity();
           renewal.AccountId   = 'opp.AccountId'; //  Invalid ID
           renewal.Name        = opp.Name + 'Renewal';
           renewal.CloseDate   = opp.CloseDate + 365;
           renewal.StageName   = 'Open';
           renewal.RecordType  = 'Renewal';  // RecordType variable doesn't exist
           renewal.OwnerId     = opp.OwnerId;
           renewals.put(renewal.Id, renewal);  //   Id for the renewal object would be null
        }
      }


      insert renewals; //  you cannot insert a map and CRUD permissions must be validated
}