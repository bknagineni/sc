public class Client_StringStack {
    
    private List<String> stack;
    
    public Client_StringStack(){
        stack = new List<String>();
    }
    
    public void push(String s){ stack.add(s); }
    
    public String pop() { 
        return stack.remove( lastItemIndex );
    }
    
    public String peak() { 
        return stack.get( lastItemIndex );
    }

    public Boolean isEmpty() { return stack.isEmpty(); }
    
    // Helper Property
    private Integer lastItemIndex {
        get { return stack.size() - 1; }
    }
}