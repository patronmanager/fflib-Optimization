public with sharing class SelectorPerformance {
	public static void go() {
		Long preloadStart = DateTime.now().getTime();
		List<String> accountFields = Selector_Contact.ACCOUNT_FIELDS;
		List<String> grandparentFields = Selector_Contact.GRANDPARENT_ACCOUNT_FIELDS;

		Long parentSelectAggregate = 0;
		Long grandparentSelectAggregate = 0;

		Long start = DateTime.now().getTime();
		System.debug('Begin');
		List<fflib_QueryFactory> qfList = new List<fflib_QueryFactory>();
		for(Integer i=0; i<3; i++){
		    Selector_Contact s = new Selector_Contact();
			fflib_QueryFactory qf = s.newLightweightQueryFactory();

		    Long parentStart = DateTime.now().getTime();
		    qf.selectFields(accountFields);
		    parentSelectAggregate += DateTime.now().getTime() - parentStart;

		    Long grandparentStart = DateTime.now().getTime();
		    qf.selectFields(grandparentFields);
		    grandparentSelectAggregate += DateTime.now().getTime() - grandparentStart;
		    
		    qfList.add(qf);
			System.debug('QF'+i);
		}

		Long mid = DateTime.now().getTime();
		String soql;
		for(fflib_QueryFactory qf : qfList){
			soql = qf.toSoql();
			System.debug('SOQL');
		}

		Long finish = DateTime.now().getTime();

		System.debug('Preload Elapsed:' + (start-preloadStart));
		System.debug('Parent Elapsed:' + parentSelectAggregate);
		System.debug('Grandparent Elapsed:' + grandparentSelectAggregate);
		System.debug('QF Elapsed (includes parent & grandparent):' + (mid-start));
		System.debug('SOQL Elapsed:' + (finish-mid));
		System.debug('Total Elapsed:' + (finish-start));

		System.debug(soql);		
	}

	public static void describe(){
		List<String> parentFields = Selector_Contact.ACCOUNT_FIELDS;
		List<String> fields = new List<String>();

		Long startSplit = DateTime.now().getTime();
		for(String path : parentFields){
			String[] splits = path.split('\\.');
			String.isBlank(splits[0]);
			fields.add(splits[1].toLowerCase());
		}
		Long finishSplit = DateTime.now().getTime();


		Long start = DateTime.now().getTime();
		Long firstHit = 0;
		Integer i = 0;
		for(String field : fields){
//			fflib_SObjectDescribe.instanceCache.get('account');//.getField(field);		
			fflib_SObjectDescribe.getDescribe('Account').getField(field);		
			if(i == 0){
				firstHit = DateTime.now().getTime() - start;
			}
			i++;

		}
		Long finish = DateTime.now().getTime();

		System.debug('Iterations: ' + i);
		System.debug('Splits Elapsed:' + (finishSplit-startSplit));
		System.debug('First Describe:' + firstHit);
		System.debug('Describe Elapsed:' + (finish-start));
	}
}