@isTest
public with sharing class NumberOfCasesTriggerHandlerTest {

    @isTest
    private static void getNumberOfCasesTest() {

        MaxNumberOfCases__c myCustomSetting = new MaxNumberOfCases__c();
        myCustomSetting.Name = 'MaxNumberOfCasesToInsertAMonth';
        myCustomSetting.maxNumberOfCases__c = '1';
        insert myCustomSetting;

        List<Case> casesList = new List<Case>();
        Case myCase = TestDataFactory.createCase();
        casesList.add(myCase);
        Boolean tooManyCases = NumberOfCasesTriggerHandler.getNumberOfCases(casesList);

        System.assertEquals(true, tooManyCases, 'system assert');

    }
}
