public with sharing class AccountHandler {
    public AccountHandler() {

    }

    public static void insertAccount(Integer newAccount){
        List<Account> addAccounts = new List<Account>();
        Integer N = 0;
        while(N < newAccount){
            Account ac = new Account();
            ac.Name = 'Acme Inc '+N;
            ac.AccountNumber = 'A000'+N;
            addAccounts.add(ac);
            N++;
        }
        INSERT addAccounts;
    }
}