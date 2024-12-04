trigger changes_for_account_revanue on Account (after update) {
    List<Account> newAccounts = new List<Account>();
    List<Account> oldAccounts = new List<Account>();
    for(Account a : Trigger.new){
        Account oldAcc = Trigger.oldMap.get(a.Id);
        newAccounts.add(a);
        oldAccounts.add(oldAcc);
    }
    TriggerAccountRevanueChanged.showDifference(newAccounts, oldAccounts);
}