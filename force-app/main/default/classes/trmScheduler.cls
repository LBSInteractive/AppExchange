global class trmScheduler implements Schedulable {

    public class ResponseScheme {
        public String valor;
}

public class ResponseSchemeSOAP {
    public String id;
    public Boolean success { get; }
        public String[] errors;
    }

global void execute(SchedulableContext cntx) {
    Datetime timeNow = System.now();
    trmScheduler nextScheduler = new trmScheduler();
    String chron_exp = '0 0 0 * * ? *';
    System.schedule('Log: ' + timeNow.getTime(), chron_exp, nextScheduler);
    service();
}

@future(callout = true)
private static void service() {

    // Request
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    // milliseconds
    request.setTimeout(20000);
    request.setEndpoint('https://www.datos.gov.co/resource/32sa-8pi3.json?$select=valor&$order=vigenciahasta%20DESC&$limit=1');

    // Http
    HTTPResponse response = http.send(request);
    Double trmHomologate = 0;


    List < ResponseScheme > lista =(List<ResponseScheme>) JSON.deserialize(response.getBody(), List<ResponseScheme>.class);
    if (!lista.isEmpty()) {
        trmHomologate = 1 / double.valueOf(lista[0].valor);

        http = new Http();
        request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v47.0/sobjects/CurrencyType/');
        request.setMethod('POST');
        request.setBody('{ "IsoCode" : "USD", "DecimalPlaces" : 2, "ConversionRate" :' + trmHomologate + ', "IsActive" : "true" }');
        request.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        response = http.send(request);
        ResponseSchemeSOAP responseSOAP = (ResponseSchemeSOAP) JSON.deserialize(response.getBody(), ResponseSchemeSOAP.class);
        if (responseSOAP.success == true) {

            System.debug('** TRM Actualizado **');

        } else {

            System.debug('** Error Inesperado **');

        }

    } else {
        System.debug('** Error inesperado **');
    }

}

}
