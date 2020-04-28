public with sharing class trmService {

    @AuraEnabled(cacheable=true)
    public static Double getTrmService() {
        CurrencyType trm = new CurrencyType();
        CurrencyType trmEmpty = new CurrencyType();
        Double parseTrm = 0;
        Double trmToday = 0;
        trm = [SELECT ConversionRate FROM CurrencyType where IsoCode = 'USD' LIMIT 1];
        parseTrm = trm != trmEmpty && trm.isSet('ConversionRate') ?  double.valueOf(trm.ConversionRate) : 0;
        trmToday = parseTrm != 0 ? (1/parseTrm) : 0;

        return trmToday;

    }

}


