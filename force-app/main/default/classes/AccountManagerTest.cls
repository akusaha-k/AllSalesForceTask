/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountManagerTest {

    /*
        This class Test Account Creation with Name and Industry (Required Field).
    */
    @isTest
    public static void createAccountTest(){
        String aName = 'Test Account';
        String aIndustry = 'Test Industry';
        Test.startTest();
        Id aId = AccountManager.createAccount(aName, aIndustry);
        Test.stopTest();

        Account a = [SELECT Id, Name, Industry FROM Account WHERE Id = :aId LIMIT 1];
        System.assertEquals(aId, a.Id, 'Account is created');
        System.assertEquals(aName, a.Name, 'Account name is Correct');
        System.assertEquals(aIndustry, a.Industry, 'Account industry is Correct');
    }

    /*
        If Name Field is empty then throw exception
    */
    @isTest
    public static void createAccountTest1(){
        String aName = '';
        String aIndustry = 'Test Industry';

        try {
            Test.startTest();
            AccountManager.createAccount(aName, aIndustry);
            Test.stopTest();
            System.assert(false, 'Expected HandledException was not thrown.');
        } catch (HandledException e) {
            System.assertEquals('Account name and industry cannot be blank.', e.getMessage());
        }
    }

    /*
        If Name Industry is empty then throw exception
    */
    @isTest
    public static void createAccountTest2(){
        String aName = 'Test Account';
        String aIndustry = '';

        try {
            Test.startTest();
            AccountManager.createAccount(aName, aIndustry);
            Test.stopTest();
            System.assert(false, 'Expected HandledException was not thrown.');
        } catch (HandledException e) {
            System.assertEquals('Account name and industry cannot be blank.', e.getMessage());
        }
    }

    /*
        This test, Update an account is Successfull or not
    */
    @isTest
    public static void updateAccountIndustryTest(){
        Account a = new Account();
        a.Name = 'Test Account1';
        a.Industry = 'Test Industry1';
        Insert a;

        Account ac = [Select Id, Industry from Account where Id =: a.Id Limit 1];
        
        String uIndustry = 'updated Industry';
        Test.startTest();
        AccountManager.updateAccountIndustry(ac.Id, uIndustry);
        Test.stopTest();

        Account a1 = [Select Id, Industry from Account where Id =: ac.Id Limit 1];
        System.Assert.areEqual(uIndustry, a1.Industry, 'Account is updated');
    }

    /*
        This test will perform for deleting an account is Successfull or not
    */
    @isTest
    public static void deleteAccountTest(){
        Account a = new Account();
        a.Name = 'Test Account3';
        a.Industry = 'Test Industry3';
        Insert a;

        Test.startTest();
        AccountManager.deleteAccount(a.Id);
        Test.stopTest();

        List<Account> ac = [Select Id From Account Where Id =: a.Id Limit 1];


        System.assertEquals(0, ac.size(), 'Account is Deleted');
    }
}