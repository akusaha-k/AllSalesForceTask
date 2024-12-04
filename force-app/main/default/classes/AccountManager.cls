public class AccountManager {
    
    // Method to create an Account with Industry field
    public static Id createAccount(String accountName, String accountIndustry) {
        try {
            if (String.isBlank(accountName) || String.isBlank(accountIndustry)) {
                throw new HandledException('Account name and industry cannot be blank.');
            }

            Account newAccount = new Account(Name = accountName, Industry = accountIndustry);
            insert newAccount;
            return newAccount.Id;

        }catch (Exception e) {
            throw new HandledException('An unexpected error occurred while creating the Account: ' + e.getMessage());
        }
    }

    // Method to update Account's Industry
    public static void updateAccountIndustry(Id accountId, String newIndustry) {
        try {
            if (accountId == null || String.isBlank(newIndustry)) {
                throw new HandledException('Account ID and industry cannot be null or blank.');
            }

            Account accountToUpdate = [SELECT Id, Industry FROM Account WHERE Id = :accountId LIMIT 1];
            if (accountToUpdate == null) {
                throw new HandledException('Account not found with Id: ' + accountId);
            }

            accountToUpdate.Industry = newIndustry;
            update accountToUpdate;
        }catch (Exception e) {
            throw new HandledException('An unexpected error occurred while updating the Account industry: ' + e.getMessage());
        }
    }

    // Method to delete an Account
    public static void deleteAccount(Id accountId) {
        try {
            if (accountId == null) {
                throw new HandledException('Account ID cannot be null.');
            }

            Account accountToDelete = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
            if (accountToDelete == null) {
                throw new HandledException('Account not found with Id: ' + accountId);
            }

            delete accountToDelete;
        }catch (Exception e) {
            throw new HandledException('An unexpected error occurred while deleting the Account: ' + e.getMessage());
        }
    }
}
