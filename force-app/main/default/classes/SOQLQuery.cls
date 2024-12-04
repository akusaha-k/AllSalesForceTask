public with sharing class SOQLQuery {
    public SOQLQuery() {

    }

    public static void contractRetriver(){
        List<Contact> contactList = [
            SELECT Id, LastName, FirstName, Account.Name
            From Contact
            WHERE LastName LIKE 'A%' AND Account.Name LIKE '%Tech%'
            ORDER BY LastName
        ];
        System.debug(contactList);

        //List<Account> a = new List<Account>();
        Integer i = 0;
        for(Contact c : contactList){
            c.Email = 'asd'+i+'@gmail.com';
            c.HomePhone = '78899'+i;
            i++;
            c.Account.Name = 'who are you';
            UPDATE c.Account;
        }
        System.debug(contactList);
        if(contactList.size() > 0){
            UPDATE contactList;
            //UPDATE a;
        }
    }

    public static void accountRetriver(){
        /*List<Account> accList = [
            SELECT Name, 
            (
                SELECT SUM(Amount), COUNT(Id)
                FROM Opportunity
                WHERE StageName LIKE 'Closed Won'
            )
            From Account
        ];*/

        List<sObject> accList = [
            SELECT Account.Name,
            COUNT(Id) totalOpportunities, 
            SUM(Amount) totalAmount
            FROM Opportunity
            WHERE StageName like 'Closed Won'
            GROUP BY Account.Name
        ];
        System.debug(accList);
    }

    public static void specificFind(){
        List<List<sObject>> retriveList = [
            FIND 'temp' IN Name Fields RETURNING Contact(LastName), Lead(LastName)
        ];

        List<Contact> conList = retriveList[0];
        List<Lead> leadList = retriveList[1];
        System.debug(conList);
        System.debug(leadList);
        
        for(Contact c : conList){
            if(c.LastName != null && !c.LastName.equals('')){
                c.LastName = c.LastName.replaceAll('temp', 'per');
            }
        }
        
        for(Lead l : leadList){
            if(l.LastName != null && !l.LastName.equals('')){
                l.LastName = l.LastName.replaceAll('temp', 'per');
            }
        }

        if(conList.size() > 0){
            UPDATE conList;
        }

        if(leadList.size() > 0){
            UPDATE leadList;
        }
    }
}