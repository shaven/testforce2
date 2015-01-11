public with sharing class GeniusEventsManagerController {

    public String searchText{get;set;}
    List<genius_com__GeniusEvent__c> listEvents {get;set;}
    
    public Boolean IsExcludeText {get;set;}
    
     public  List<genius_com__GeniusEvent__c> getListEvents() {
        return listEvents ;
    }
    
    public  Boolean getDisplayList() {
    
        if (listEvents == null)
            return false;
            
        if (listEvents.size() > 0) 
            return true;
        else    
            return false;
    }
    
    
    public PageReference searchEvents(){
        String matchCondition = ' ';
        if (IsExcludeText )
        {
            matchCondition = ' NOT '; 
        } 
        
        String Query = '';
        Query = 'Select g.genius_com__RelatedToLead__c, g.genius_com__RelatedToContact__c, g.genius_com__RelatedToAccount__c,g.genius_com__RelatedToLead__r.Name, g.genius_com__RelatedToContact__r.Name, g.genius_com__RelatedToAccount__r.Name, g.genius_com__EventType__c, g.genius_com__EventDateTime__c, g.genius_com__EmailType__c, g.genius_com__EmailSubject__c, g.genius_com__ActivityName__c, g.id, g.Name From genius_com__GeniusEvent__c g where ' + matchCondition  + ' genius_com__EmailSubject__c  LIKE \'%' + searchText + '%\'';
        listEvents = new List<genius_com__GeniusEvent__c>();
        listEvents = Database.query(Query);
        //listEvents = new List<genius_com__GeniusEvent__c>([Select g.genius_com__EventType__c, g.genius_com__EventDateTime__c, g.genius_com__EmailType__c, g.genius_com__EmailSubject__c, g.genius_com__ActivityName__c, g.id, g.Name From genius_com__GeniusEvent__c g where genius_com__EmailSubject__c like %:searchText%]);
        
        String Message = '';
        
        if (listEvents != null)
        {
        if (listEvents.size() > 1000)
        {
            Message = listEvents.size() + ' records found. First 1000 records are displayed.';
            Query = 'Select g.genius_com__RelatedToLead__c, g.genius_com__RelatedToContact__c, g.genius_com__RelatedToAccount__c,g.genius_com__RelatedToLead__r.Name, g.genius_com__RelatedToContact__r.Name, g.genius_com__RelatedToAccount__r.Name, g.genius_com__EventType__c, g.genius_com__EventDateTime__c, g.genius_com__EmailType__c, g.genius_com__EmailSubject__c, g.genius_com__ActivityName__c, g.id, g.Name From genius_com__GeniusEvent__c g where ' + matchCondition  + ' genius_com__EmailSubject__c  LIKE \'%' + searchText + '%\' limit 1000';
            listEvents = Database.query(Query);         
        }
        else if (listEvents.size() == 0)
        {
            Message = 'No record(s) found.';
        }
        else
        {
            Message = listEvents.size() + ' record(s) found.';
        }
        
        }
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Message));
        return null;
    
    }
    
     public PageReference deleteEvents(){
        String Query = '';
        Query = 'Select  g.genius_com__RelatedToLead__c, g.genius_com__RelatedToContact__c, g.genius_com__RelatedToAccount__c, g.genius_com__EventType__c, g.genius_com__EventDateTime__c, g.genius_com__EmailType__c, g.genius_com__EmailSubject__c, g.genius_com__ActivityName__c, g.id, g.Name From genius_com__GeniusEvent__c g where genius_com__EmailSubject__c like \'%' + searchText + '%\'';
        /*    
        listEvents = new List<genius_com__GeniusEvent__c>();
        listEvents = Database.query(Query);
        //listEvents = new List<genius_com__GeniusEvent__c>([Select g.genius_com__EventType__c, g.genius_com__EventDateTime__c, g.genius_com__EmailType__c, g.genius_com__EmailSubject__c, g.genius_com__ActivityName__c, g.id, g.Name From genius_com__GeniusEvent__c g where genius_com__EmailSubject__c like %:searchText%]);
        */
        String Message = '';
        
        if (listEvents != null)
        {
            try
            {
                delete listEvents ;
                Message = listEvents.size() + ' record(s) deleted.';
                //listEvents = Database.query(Query);
                listEvents = new List<genius_com__GeniusEvent__c>();
        
            }
            catch(exception ex)
            {
                Message = ex.getMessage();
            }
        }
        else
        {
            Message = 'No records to delete';
        }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Message));
        return null;
    
    }
    

}