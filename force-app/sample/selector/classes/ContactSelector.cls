public with sharing class ContactSelector
	extends SObjectSelector
	implements IContactSelector
{
	public static IContactSelector newInstance()
	{
		return (IContactSelector) Application.Selector.newInstance(Contact.SObjectType);
	}

	public override Schema.sObjectType sObjectType()
	{
		return Contact.SObjectType;
	}

	private List<Schema.SObjectField> getAdditionalSObjectFieldList()
	{
		List<Schema.SObjectField> fieldList = Contact.SObjectType.getDescribe(SObjectDescribeOptions.DEFERRED).fields.getMap().values();
		return fieldList;
	}

	private Set<String> getLookupFieldSet()
	{
		return new Set<String>();
	}

	public List<Contact> selectById(Set<Id> idSet)
	{
		return (List<Contact>) selectSObjectById(idSet);
	}
}
