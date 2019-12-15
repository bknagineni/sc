trigger trgInsertContact on Account (after insert)
 {
      Account[] acc = Trigger.new;  
      Contact c = new Contact();
      c.Accountid = acc[0].Id;
      c.Email = 'test@test.com';
      c.LastName = acc[0].Name;
      insert c;      
 }