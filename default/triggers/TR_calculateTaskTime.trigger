trigger TR_calculateTaskTime on Task(after insert, after update, before insert, before update) {
    // Check if the triggers should be executed for the current User
       ID BHID = [select id, name from businesshours where name ='default'].id;
       system.debug('BHID....: ' + BHID);
      if ( trigger.isupdate && trigger.isBefore ){
          //list<task> ts = (task)trigger.new;
          for (Task T: Trigger.new)
          {
              if(t.status == 'Completed' && (T.MileageHelper__Task_Start_Date__c!=null && T.MileageHelper__TaskCompletionDate__c!=null) )
              {
                Long inputMillisecs = BusinessHours.diff(BHID, T.MileageHelper__Task_Start_Date__c,T.MileageHelper__TaskCompletionDate__c);
                system.debug('inputMillisecs.....:  ' + inputMillisecs);
                Integer total_duration_in_seconds = (inputMillisecs/1000).intValue(); //duration in seconds
                system.debug('total_duration_in_seconds.....:  ' + total_duration_in_seconds);
                //Integer minute_result = math.mod(math.floor(total_duration_in_seconds/60).intValue(),60); //number of minutes
                Integer minute_result = (math.floor(total_duration_in_seconds/60).intValue()); //number of minutes
                system.debug('minute_result.....:  ' + minute_result);
                Integer hour_result = (math.floor(minute_result/60).intValue()); //number of hours
                
                Integer day_result = (math.floor(hour_result/8).intValue()); //number of days
                system.debug('hour_result.....:  ' + hour_result);
                system.debug('day_result.....:  ' + day_result);  
                t.MileageHelper__Total_Days__c = day_result;
                t.MileageHelper__Total_Hours__c = hour_result;
                t.MileageHelper__Total_Minutes__c = minute_result;
                t.MileageHelper__Time_Taken__c = String.valueOf(day_result)+' DD '+ String.valueOf(hour_result)+' HH ' +String.valueOf(minute_result)+' M ' ;
                  //system.debug('hours....: ' + hours);
              }
          }
          
      }
      
}