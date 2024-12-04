public virtual with sharing class Employee {
    private String name;
    private Integer employeeId;
    private String department;
    public Employee() {

    }
    public Employee(String name, Integer employeeId, String department) {
        this.name = name;
        this.employeeId = employeeId;
        this.department = department;
    }

    public virtual void displayDetails(){
            System.debug('Employee Name : '+name);
            System.debug('Employee Id : '+employeeId);
            System.debug('Employee Department : '+department);
    }
}