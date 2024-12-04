public with sharing class Main {
    private List<Employee> empList;
    public Main() {
        empList = new List<Employee>();
        Employee em = new Employee('Jhon Smith', 1,'HR');
        Employee em1 = new Employee('Marker Been', 2,'Software');
        Employee em2 = new Manager('July marker', 3, 'Hardware', 3);
        Employee em3 = new Manager('Jack Sparo', 4, 'HR', 2);
        empList.add(em);
        empList.add(em1);
        empList.add(em2);
        empList.add(em3);
    }

    public void display(){
        for(Employee em : empList){
            em.displayDetails();
        }
    }
    
}