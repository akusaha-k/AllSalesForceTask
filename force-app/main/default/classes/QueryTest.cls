public with sharing class QueryTest {
    public QueryTest() {

    }

    public static void getEmployee(){
        Date today = Date.today();
        Date yesterday = today.addDays(-1);

        List<Account> empList = [
            SELECT Name, Industry, NumberOfEmployees, 
                (SELECT Name, StageName FROM Opportunities WHERE CreatedDate = today),
                (SELECT CaseNumber, Status FROM Cases WHERE CreatedDate = yesterday)
            FROM Account 
            WHERE NumberOfEmployees > 3500
        ];

        for(Account emp : empList){
            System.debug('Name: '+emp.Name);
            System.debug('Industry: '+emp.Industry);
            System.debug('NumberOfEmployees: '+emp.NumberOfEmployees);

            for(Opportunity opp : emp.Opportunities){
                System.debug('Opportunity Name: '+opp.Name);
                System.debug('Opportunity StageName: '+opp.StageName);
            }

            for(Case cs : emp.Cases){
                System.debug('Case Number: '+cs.CaseNumber);
                System.debug('Case Status: '+cs.Status);
            }
            System.debug('\n');
        }

    }

    public static void newEmployeeList(){
        List<String> industryList = new List<String>{'Agriculture', 'Banking', 'Chemicals', 'Communications'};
        List<Account> empList1 = [
            SELECT Name, Industry 
            FROM Account 
            WHERE Industry IN :industryList AND
            Id IN (SELECT AccountId FROM Contact WHERE Email LIKE '%@gmail.com')
        ];
        for(Account emp : empList1){
            System.debug('Name: ' + emp.Name);
            System.debug('Industry: ' + emp.Industry);
            System.debug('\n');
        }
    }
}