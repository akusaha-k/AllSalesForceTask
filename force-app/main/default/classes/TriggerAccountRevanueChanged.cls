public with sharing class TriggerAccountRevanueChanged {
    public TriggerAccountRevanueChanged() {

    }
    /*
        If AnnualRevenue is changed more than 20% then send mail to Account owner
    */
    public static void showDifference(List<Account> newList, List<Account> oldList){
        //for getting owner mail
        Set<Id> allIds = new Set<Id>();
        for (Account acc : newList) {
            allIds.add(acc.OwnerId);
        }
        Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Email FROM User WHERE Id IN :allIds]);

        for(Integer i=0; i<newList.size(); i++){
            //calculation revinue changed
            Decimal newAccR = newList[i].AnnualRevenue;
            Decimal oldAccR = oldList[i].AnnualRevenue;

            User owner = userMap.get(newList[i].OwnerId);
            if(newAccR != null && oldAccR != null && (oldAccR != newAccR)){
                Decimal changePercent = ((newAccR - oldAccR)/oldAccR)*100;
                changePercent = changePercent.setScale(3);
                if(Math.abs(changePercent) > 20){
                    String address = owner.Email;
                    String subject = 'Account Annual Revenue change';
                    String text = 'Account Annual Revenue changed by :' + changePercent + '%\n'+
                    'you can mesaure thing.\nThank You.\nThis is an automated Mail' ;
                    TriggerAccountRevanueChanged.sendMail(address, subject, text);
                }
            }
        }
    }

    /*
        This method is design for sending mail
    */
    public static void sendMail(String address, String subject, String body) {
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { address });
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            System.debug('Email sent successfully to: ' + address);
        } catch (Exception e) {
            System.debug('Error sending email: ' + e.getMessage());
        }
    }    
    
}