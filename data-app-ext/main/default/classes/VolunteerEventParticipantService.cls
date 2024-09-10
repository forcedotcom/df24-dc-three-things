public with sharing class VolunteerEventParticipantService {
    @AuraEnabled
    public static List<Object> getParticipantsByRecordId(Id recordId) {
        try {
            ConnectApi.CdpQueryInput query = new ConnectApi.CdpQueryInput();
            // the sql is a string so recordId must be wrapped in single quotes
            query.sql = 'SELECT mvpbo3__Id__c, mvpbo3__Name__c, mvpbo3__CreatedDate__c, mvpbo3__mvpbo3_Participant_c__c, mvpbo3__mvpbo3_Volunteer_Event_c__c FROM mvpbo3__Volunteer_Event_Participant_Home__dlm WHERE mvpbo3__mvpbo3_Volunteer_Event_c__c = \'' + recordId + '\' ORDER BY mvpbo3__CreatedDate__c DESC LIMIT 5';

            ConnectApi.CdpQueryOutputV2 response = ConnectApi.CdpQuery.queryAnsiSqlV2(query);
            Map<String, ConnectApi.CdpQueryMetadataItem> metadata = response.metadata;
            System.debug(metadata);

            return response.data;
       
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}