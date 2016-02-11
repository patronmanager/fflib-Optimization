public with sharing class Selector_Contact extends fflib_SObjectSelector
{
	public Selector_Contact(){
		super(false,false,false,false);
	}

	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			Contact.AccountId,
			Contact.AssistantName,
			Contact.AssistantPhone,
			Contact.Birthdate,
			Contact.CreatedById,
			Contact.CreatedDate,
			Contact.Department,
			Contact.Description,
			Contact.Email,
			Contact.EmailBouncedDate,
			Contact.EmailBouncedReason,
			Contact.Fax,
			Contact.FirstName,
			Contact.HasOptedOutOfEmail,
			Contact.HomePhone,
			Contact.Id,
			Contact.IsDeleted,
			Contact.IsEmailBounced,
			Contact.Jigsaw,
			Contact.JigsawContactId,
			Contact.LastActivityDate,
			Contact.LastCURequestDate,
			Contact.LastCUUpdateDate,
			Contact.LastModifiedById,
			Contact.LastModifiedDate,
			Contact.LastName,
			Contact.LastReferencedDate,
			Contact.LastViewedDate,
			Contact.LeadSource,
			Contact.MailingCity,
			Contact.MailingCountry,
			Contact.MailingLatitude,
			Contact.MailingLongitude,
			Contact.MailingPostalCode,
			Contact.MailingState,
			Contact.MailingStreet,
			Contact.MasterRecordId,
			Contact.MobilePhone,
			Contact.OtherAddress,
			Contact.OtherCity,
			Contact.OtherCountry,
			Contact.OtherLatitude,
			Contact.OtherLongitude,
			Contact.OtherPhone,
			Contact.OtherPostalCode,
			Contact.OtherState,
			Contact.OtherStreet,
			Contact.OwnerId,
			Contact.Phone,
			Contact.PhotoUrl,
			Contact.ReportsToId,
			Contact.Salutation,
			Contact.SystemModstamp,
			Contact.Title			
		};
	}
	
	public static List<String> ACCOUNT_FIELDS{
		get{
			if(ACCOUNT_FIELDS == null){
				ACCOUNT_FIELDS = new List<String>();
				Selector_Account a = new Selector_Account();
				for(Schema.SObjectField f : a.getSObjectFieldList()){
					ACCOUNT_FIELDS.add('Account.' + f.getDescribe().getLocalName());
				}
			}
			return ACCOUNT_FIELDS;
		}
		private set;
	}

	public static List<String> GRANDPARENT_ACCOUNT_FIELDS{
		get{
			if(GRANDPARENT_ACCOUNT_FIELDS == null){
				GRANDPARENT_ACCOUNT_FIELDS = new List<String>();
				Selector_Account a = new Selector_Account();
				for(Schema.SObjectField f : a.getSObjectFieldList()){
					GRANDPARENT_ACCOUNT_FIELDS.add('Account.Parent.' + f.getDescribe().getLocalName());
				}
			}
			return GRANDPARENT_ACCOUNT_FIELDS;
		}
		private set;
	}

	public Schema.SObjectType getSObjectType()
	{
		return Contact.sObjectType;
	}

	public List<Contact> selectById(Set<ID> idSet)
	{
		return (List<Contact>) selectSObjectsById(idSet);
	}

}