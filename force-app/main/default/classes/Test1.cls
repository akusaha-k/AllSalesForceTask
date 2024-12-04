public with sharing class Test1 {
    private List<String> cityNames;
    private List<String> uniqueCityNames;
    public Test1() {
        cityNames = new List<String>{'New York', 'Paris', 'New York', 'Berlin', 'Paris', 'Tokyo'};
    }
    public void removeDuplicate(){
        uniqueCityNames = new List<String>();
        for (String cityName : cityNames) {
            if (!uniqueCityNames.contains(cityName)) {
                uniqueCityNames.add(cityName);
            }
        }
        uniqueCityNames.sort();
        system.System.debug(uniqueCityNames);
    }
}