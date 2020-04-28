@isTest
private class trmServiceTest {

    @isTest static void testIsDouble() {
        Boolean isDouble = true;
        try {
            Double trmServiceResponse = trmService.getTrmService();
        } catch (Exception e) {
            isDouble = false;
        }

        System.assertEquals(true, isDouble);
    }

}
