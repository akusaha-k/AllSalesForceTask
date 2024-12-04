public with sharing class CollectionTesting {
    public CollectionTesting() {

    }

    public void listCollection(){
        List<Integer> ints = new Integer[0];
        ints.add(1);
        ints.add(2);
        system.debug(ints);


        List<string> l = new List<string>();
        system.debug(l);
       
        List<string> g = new List<string>{'Tea','Sugar','Honey','Milk'};
        system.System.debug(g);
        g.add('Cocoa');
        system.debug(g);
    }
}