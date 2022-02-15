trigger NumberOfCases on Case (before insert) {

      Boolean tooManyCases = NumberOfCasesTriggerHandler.getNumberOfCases(Trigger.new);
      System.debug('tooManyCases: ' + tooManyCases);
}