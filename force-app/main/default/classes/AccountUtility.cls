public with sharing class AccountUtility {
    public AccountUtility() {

    }

    public static void viewAnnualRevenue(){
        List<Account> accountsList = [Select Name, AnnualRevenue From Account];
        for(Account ac : accountsList){
            String acctRev = ' account name: '+ac.Name+', Annual Revenue: '+ac.AnnualRevenue;
            system.debug(acctRev);
        }
    }
}