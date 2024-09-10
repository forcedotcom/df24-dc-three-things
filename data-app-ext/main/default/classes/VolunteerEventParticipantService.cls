public with sharing class VolunteerEventParticipantService {
    @AuraEnabled
    public static List<Object> getParticipantsByRecordId(Id recordId) {
        try {
            ConnectApi.CdpQueryInput query = new ConnectApi.CdpQueryInput();
            // the sql is a string so recordId must be wrapped in single quotes
            query.sql = 'SELECT mvpbo3__Id__c, mvpbo3__Name__c, mvpbo3__CreatedDate__c, mvpbo3__mvpbo3_Participant_c__c, mvpbo3__mvpbo3_Volunteer_Event_c__c FROM mvpbo3__Volunteer_Event_Participant_Home__dlm WHERE mvpbo3__mvpbo3_Volunteer_Event_c__c = \'' + recordId + '\' ORDER BY mvpbo3__CreatedDate__c DESC LIMIT 5';

            ConnectApi.CdpQueryOutputV2 response = ConnectApi.CdpQuery.queryAnsiSqlV2(query);
            Map<String, ConnectApi.CdpQueryMetadataItem> metadata = response.metadata;
            List<ConnectApi.CdpQueryV2Row> data = response.data;

            // List will hold the result once field names and values are joined
            List<Map<String, Object>> result = new List<Map<String, Object>>();

            // Iterate over the data rows
            for (ConnectApi.CdpQueryV2Row row : data) {
                Map<String, Object> record = new Map<String, Object>();

                // Iterate over the metadata to get field names and corresponding values
                for (String fieldName : metadata.keySet()) {
                    record.put(fieldName, row.rowData[Integer.valueOf(metadata.get(fieldName).placeInOrder)]);
                }

            result.add(record);
        }
        // result contains an array of objects that can be easily consumed by LWC
        return result;
       
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}