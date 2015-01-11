@isTest
private class GeniusEventsManagerController_Test {

    static testMethod void thisUnitTest() {
    
        
        GeniusEventsManagerController objMan = new GeniusEventsManagerController();
        
        genius_com__GeniusEvent__c rec= new genius_com__GeniusEvent__c();
        rec.genius_com__EventType__c = 'Email';
        rec.genius_com__EmailSubject__c = 'test';
        rec.genius_com__ActivityName__c = 'test';
        insert rec;
        
        objMan.IsExcludeText = false;
        objMan.searchText = 'zzzzzzzzzzzzzzzzzzz';
        objMan.searchEvents();
        
        
        objMan.searchText = 'test';
        objMan.searchEvents();
        objMan.getDisplayList();
        objMan.deleteEvents();
        objMan.getListEvents();
        
        objMan.IsExcludeText = true;
        objMan.searchEvents();
        objMan.getDisplayList();
        
        
        
    }
}