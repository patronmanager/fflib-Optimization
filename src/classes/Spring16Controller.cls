public class Spring16Controller {
    public PatronTicket__TicketOrder__c theOrder { get; set; }
    RecordType tbqRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND DeveloperName='ToBeQualified' AND NamespacePrefix = 'PatronSignup'];
    public Spring16Controller() {
        theOrder = createNewOrder();
    }
    
    public PageReference sendOrderConfirmationEmail() {
        Contact theContact = new Contact(
            FirstName = theOrder.PatronTicket__FirstName__c,
        	LastName = theOrder.PatronTicket__LastName__c,
        	Email = theOrder.PatronTicket__Email__c,
            RecordTypeId = tbqRecordType.Id
        );
        insert theContact;
        theOrder.PatronTicket__Contact__c = theContact.Id;
        insert theOrder;
        
		PatronTicket__TicketOrder__c ticketOrder = [SELECT Id, Name, PatronTicket__DeliveryMethod__c, PatronTicket__Contact__c, PatronTicket__Contact__r.Email,
			PatronTicket__Salutation__c, PatronTicket__FirstName__c, PatronTicket__LastName__c, PatronTicket__OrderTotal__c, PatronTicket__Email__c, 
			PatronTicket__StreetAddress__c, PatronTicket__City__c, PatronTicket__State__c, PatronTicket__PostalCode__c, PatronTicket__PaymentMethod__c,
			PatronTicket__ShippingSalutation__c, PatronTicket__ShippingFirstName__c, PatronTicket__ShippingLastName__c,
			PatronTicket__ShippingStreetAddress__c, PatronTicket__ShippingCity__c, PatronTicket__ShippingState__c, PatronTicket__ShippingPostalCode__c,
			PatronTicket__OrderStatus__c, PatronTicket__SubscriptionStatus__c, PatronTicket__Type__c, OwnerId
			FROM PatronTicket__TicketOrder__c WHERE Id=:theOrder.Id];
        
        EmailTemplate template = [SELECT Id, Name, NamespacePrefix FROM EmailTemplate WHERE DeveloperName = 'Spring16OrderConfirmationTemplate' AND IsActive = true];
        
		// Create and send a single email message to the targetId      
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setTemplateId(template.Id);
		email.setTargetObjectId(theContact.Id);
        email.setWhatId(theOrder.Id);
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
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Order confirmation email sent successfully'));
        }
        delete theContact;
        theOrder = createNewOrder();
        return null;
    }
    
    private PatronTicket__TicketOrder__c createNewOrder() {
        PatronTicket__TicketOrder__c ticketOrder = new PatronTicket__TicketOrder__c();
        ticketOrder.PatronTicket__FirstName__c = 'Test';
        ticketOrder.PatronTicket__LastName__c = 'Order';
        ticketOrder.PatronTicket__Email__c = 'test.order@tom.9summer.com';
        ticketOrder.PatronTicket__OrderStatus__c = 'Draft';
        ticketOrder.PatronTicket__DeliveryMethod__c = 'Email';
        ticketOrder.PatronTicket__DonationAmount__c = 1.00;
        ticketOrder.PatronTicket__PaymentMethod__c = 'Cash';
        return ticketOrder;
    }
}