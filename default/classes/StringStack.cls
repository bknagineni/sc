public class StringStack {
    public void push(String s){}
    public String pop() { return null; }
    public String peak() { return null; }
    public Boolean isEmpty() { return true; }

/* Verifies that push(), pop() and peak() work correctly
 * when there is only 1 object on the Stack. */
static testMethod void basicTest() {
    // Instantiate a StringStack.
    StringStack stack = new StringStack();
    
    // Verify the initial state is as expected.
    System.assert(stack.isEmpty());
    
    // Set up some test data.
    String onlyString = 'Only String';
    
    // Call the push() method and verify the Stack is no longer empty
    stack.push(onlyString);
    System.assert(!stack.isEmpty());
    
    // Verify that the value we pushed on the Stack is the one we expected
    String peakValue = stack.peak();
    System.assertEquals(onlyString, peakValue);
    System.assert(!stack.isEmpty());
    
    // Verify the Stack state after pop() is called.
    String popValue = stack.pop();
    System.assertEquals(onlyString, popValue);
    System.assert(stack.isEmpty());
}
    

}