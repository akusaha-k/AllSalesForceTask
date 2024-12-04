public class OuterClass{
    private Integer val = 10;
    public class InnerClass{
        OuterClass oc = new OuterClass();
        public void display(){
            System.debug(oc.val);
        }
    }
}
