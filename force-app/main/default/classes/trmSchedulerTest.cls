@isTest
private class trmSchedulerTest {
    
    @isTest static void trmScheduler(){

        Test.startTest();
        Datetime timeNow = System.now();
        trmScheduler nextScheduler = new trmScheduler();
        String chron_exp = '0 0 0 * * ? *';

        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource('https://www.datos.gov.co/resource/32sa-8pi3.json?$select=valor&$order=vigenciahasta%20DESC&$limit=1', 'trmSchedulerTestMock_200GOV');
        multimock.setStaticResource(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v47.0/sobjects/CurrencyType/', 'trmSchedulerTestMock_200SOAP');
        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, multimock);
        System.schedule('Log: ' + timeNow.getTime(), chron_exp, nextScheduler);
        Test.stopTest();


    }

}
