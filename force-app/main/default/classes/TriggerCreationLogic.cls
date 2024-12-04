public with sharing class TriggerCreationLogic {
    public TriggerCreationLogic() {

    }

    public static void showError(List<Account> acc){
        if(Trigger.isExecuting){
            System.debug('Calling From Trigger');
        }else{
            System.debug('Calling From other');
        }
        for(Account a : acc){
            if(a.AnnualRevenue < 1000000 && a.Type.equals('Customer - Direct')){
                a.addError('Annual Revenue cannot be less than 1000000');
            }
        }
    }
}