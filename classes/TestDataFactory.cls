public with sharing class TestDataFactory {
    public static Case createCase() {

        Case myCase = new Case(Origin='Phone', OwnerId=userinfo.getuserid());

        if (Case.SObjectType.getDescribe().isCreateable()) {
            insert myCase;
        }

        return myCase;
    }
}
