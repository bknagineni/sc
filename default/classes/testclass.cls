public class testclass
{
    public void testMethods()
    {
        List<Integer> myList = new Integer[6];
        myList.add(0, 47);
        myList.add(1, 52);
        system.assertEquals(myList.get(1), 52);
    }
}