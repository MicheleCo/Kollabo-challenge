// Automatically create a Renewal Opp for closed won deals
trigger CreateRenewalCorrected on Opportunity (before update) {

      CreateRenewalTriggerHandler.handleRenewal(Trigger.new);
      
}