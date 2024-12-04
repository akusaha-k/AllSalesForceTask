public with sharing class Manager extends Employee{
    private Integer teamSize;
    public Manager() {

    }
    public Manager(String name, Integer employeeId, String department, Integer teamSize) {
        super(name, employeeId, department);
        this.teamSize = teamSize;
    }

    public override void displayDetails(){
        super.displayDetails();
        System.debug('Team Size: '+teamSize);
    }
}