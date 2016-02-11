public with sharing class Selector_Account extends fflib_SObjectSelector{
	public Selector_Account(){
		super(false,false,false,false);
	}

	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			Account.AccountNumber,
			Account.AccountSource,
			Account.AnnualRevenue,
			Account.BillingCity,
			Account.BillingCountry,
			Account.BillingLatitude,
			Account.BillingLongitude,
			Account.BillingPostalCode,
			Account.BillingState,
			Account.BillingStreet,
			Account.CreatedById,
			Account.CreatedDate,
			Account.Description,
			Account.Fax,
			Account.Id,
			Account.Industry,
			Account.IsDeleted,
			Account.Jigsaw,
			Account.JigsawCompanyId,
			Account.LastActivityDate,
			Account.LastModifiedById,
			Account.LastModifiedDate,
			Account.LastReferencedDate,
			Account.LastViewedDate,
			Account.MasterRecordId,
			Account.Name,
			Account.NumberOfEmployees,
			Account.OwnerId,
			Account.Ownership,
			Account.ParentId,
			Account.Phone,
			Account.PhotoUrl,
			Account.Rating,
			Account.ShippingCity,
			Account.ShippingCountry,
			Account.ShippingLatitude,
			Account.ShippingLongitude,
			Account.ShippingPostalCode,
			Account.ShippingState,
			Account.ShippingStreet,
			Account.Sic,
			Account.SicDesc,
			Account.Site,
			Account.SystemModstamp,
			Account.TickerSymbol,
			Account.Type,
			Account.Website
		};
	}
	
	public Schema.SObjectType getSObjectType()
	{
		return Account.sObjectType;
	}

	public List<Account> selectById(Set<ID> idSet)
	{
		return (List<Account>) selectSObjectsById(idSet);
	}

}