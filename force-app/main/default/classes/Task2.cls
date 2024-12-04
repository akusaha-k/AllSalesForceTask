public with sharing class Task2 {
    Map<String, Integer> empDetails;
    Integer id = null;
    public Task2() {
        empDetails = new Map<String, Integer>();
        empDetails.put('John', 10000);
        empDetails.put('Mark', 50000);
        empDetails.put('Mary', 453);
        empDetails.put('Salim', 879);
        empDetails.put('Tourst', 8765);
    }

    public void disPlayEmpDetails(){
        for(String key : empDetails.keySet()){
            if(key.equals('John')){
                id = empDetails.get(key);
            }
            system.debug('Employee Name: ' + key + ', Id: '+empDetails.get(key));
        }
        if(id != null){
            system.debug('Employee Exists -> Id is : ' + id);
        }
    }
}