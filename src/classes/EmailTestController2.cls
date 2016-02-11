public class EmailTestController2 {
	
	public String contactId { get; set; }
	public Contact theContact { get; set; }
	
	public EmailTestController2() { 
		System.debug('In Constructor');
	}
	
	public PageReference loadContact() {
		theContact = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :contactId];
		return null;
	}
	
	public PageReference sendEmail() {
		EmailTemplate template = [SELECT Id, Name, NamespacePrefix FROM EmailTemplate WHERE DeveloperName = 'CustomTemplate' AND IsActive = true];
		
		// Create and send a single email message to the targetId      
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setTemplateId(template.Id);
		email.setTargetObjectId(theContact.Id);
		email.setSaveAsActivity(false);
		Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
		if (!results[0].isSuccess()) {
			String errorString;
			Messaging.SendEmailError[] errorList = results[0].getErrors();
			if (errorList != null && errorList.size() > 0) {
				errorString = 'sendEmail failed with the following errors:';
				for (Messaging.SendEmailError error : errorList) {
					errorString += '\n' + error.getMessage();
				}
			} else {
				errorString = 'sendEmail failed with an unknown error.';
			}
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorString));
		} else {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email sent successfully'));
		}
		return Page.EmailTestPage2;
	}
}