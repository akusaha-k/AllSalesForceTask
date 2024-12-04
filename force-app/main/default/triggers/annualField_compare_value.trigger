trigger annualField_compare_value on Account (before insert, after insert) {
    List<Account>  newAccounts = new List<Account>();
    for(Account a : Trigger.new){
        // if(a.AnnualRevenue < 1000000 && a.Type.equals('Customer - Direct')){
        //     a.addError('Annual Revenue cannot be less than 1000000');
        // }
        newAccounts.add(a);
    }
    TriggerCreationLogic.showError(newAccounts);
}