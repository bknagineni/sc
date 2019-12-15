/* Verifies that push(), pop() and peak() work correctly
 * when there are multiple objects on the Stack. */
public class TestStringStack
{ 
static testMethod void verifyCorrectOrderTest() {
    // Instantiate a Client_StringStack.
    Client_StringStack stack = new Client_StringStack();
    
    // Set up some test data.
    String bottomString = 'Bottom String';
    String middleString = 'Middle String';
    String topString = 'Top String';
    
    // Call the push() method with multiple objects
    stack.push(bottomString);
    stack.push(middleString);
    stack.push(topString);
    
    // Verify that the 'top' object is the object we expected 
    String peakValue = stack.peak();
    System.assertEquals(topString, peakValue);
    
    // Verify that the order of the objects is as we expected
    String popValue = stack.pop();
    System.assertEquals(topString, popValue);
    popValue = stack.pop();
    System.assertEquals(middleString, popValue);
    popValue = stack.pop();
    System.assertEquals(bottomString, popValue);
    System.assert(stack.isEmpty());
}
}