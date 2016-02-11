public class EmailTestController {
    public Contact theContact { get; set; }
    
    public EmailTestController() {
        theContact = createNewContact();
    }
    
    public PageReference sendEmail() {
        insert theContact;
        
        EmailTemplate template = [SELECT Id, Name, NamespacePrefix FROM EmailTemplate WHERE DeveloperName = 'VisualforceTemplate' AND IsActive = true];
        
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
        delete theContact;
        theContact = createNewContact();
        return null;
    }
    
    private Contact createNewContact() {
        Contact c = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test.contact@tom.9summer.com'
        );
        return c;
    }
}