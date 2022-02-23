public with sharing class NumberOfCasesTriggerHandler {


    public static Boolean getNumberOfCases(List<Case> cases) {

        Boolean tooManyCases;

        Integer maxNumberOfCases = Integer.ValueOf(MaxNumberOfCases__c.getValues('MaxNumberOfCasesToInsertAMonth').maxNumberOfCases__c);  //99

        String username = [SELECT Name FROM user WHERE id=:userinfo.getuserid()].Name;

        System.debug('maxNumberOfCases: ' + maxNumberOfCases);
        System.debug('username: ' + username);

        Set<Id> userIds = new Set<Id>();
        Map<Id, Integer> countingCasesMap = new Map<Id, Integer>();
        for (Case c: cases) {
            userIds.add(c.OwnerId);
        }

        List<AggregateResult> countingCasesList = [SELECT count(Id), CreatedById
                                                FROM Case
                                                WHERE CreatedDate = THIS_MONTH AND CreatedById in :userIds
                                                WITH SECURITY_ENFORCED
                                                GROUP BY CreatedById];

        System.debug('countingCasesList: ' + countingCasesList);

        for (AggregateResult result: countingCasesList) {
            countingCasesMap.put((Id) result.get('CreatedById'), (Integer) result.get('expr0'));
        }

        System.debug('countingCasesMap: ' + countingCasesMap);

        for (Case c: cases) {
            if (countingCasesMap.get(c.OwnerId) > maxNumberOfCases-1) {
                c.addError('Too many cases created this month for user '+username+' ('+userinfo.getuserid()+'): ' + maxNumberOfCases);
                tooManyCases = true;
            }
            else{
                tooManyCases = false;
            }
        }
        return tooManyCases;
    }
}
