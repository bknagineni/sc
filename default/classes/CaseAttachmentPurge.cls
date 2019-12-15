global class CaseAttachmentPurge implements Database.Batchable<sObject>, Schedulable {

global final String query;

global CaseAttachmentPurge(String objectType) {
    query = 'SELECT Id FROM ' + objectType +  'WHERE ParentId IN(SELECT Id FROM Case ';
}

global void execute(SchedulableContext sc) {
    Database.executebatch(new CaseAttachmentPurge('Attachment'));
}

global Database.QueryLocator start(Database.BatchableContext br) {
    return Database.getQueryLocator(query);
}

global void execute(Database.BatchableContext bc, List<sObject> scope) {
    delete scope;
}

global void finish(Database.BatchableContext bc) {}
}