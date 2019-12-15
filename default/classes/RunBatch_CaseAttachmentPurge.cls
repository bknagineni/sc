global class RunBatch_CaseAttachmentPurge implements Schedulable{
String objname='Attachment';
global void execute(schedulablecontext sc){
Id batchInstanceId = Database.executeBatch(new UpdateAccountFields(objname), 5);
}

}