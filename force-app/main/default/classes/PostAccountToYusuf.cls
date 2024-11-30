public class DataSync {

    public static void sendAccountsToOrg2() {
        try {
            // TokenFetcher sınıfından Access Token al
            String accessToken = '00Dak00000DTXsL!AQEAQKq14le1vvS1hLRlmZjb6zIKsfYjS5UC9Mqy6XAqN0GifTbDBuEoC_tkrMaMVc18EIHl4sXh1BzZOnlBgpM_DfS8DMtB';
            
            // Org 1'deki tüm Account kayıtlarını al
            List<Account> accounts = [SELECT Name, Phone, BillingCity, BillingState FROM Account];
             
            // Her bir Account kaydı için Org 2'ye POST isteği yap
            for (Account acc : accounts) {
                HttpRequest req = new HttpRequest();
                
                // Org 2'deki Account eourOrg2Instance.salesforce.comndpoint'ine gönderim yap
                req.setEndpoint('https://littlecake-dev-ed.develop.my.salesforce.com/services/data/v52.0/sobjects/Account/');
                req.setMethod('POST');
                req.setHeader('Authorization', 'Bearer ' + accessToken);  // Access Token'ı Authorization header'ına ekle
                req.setHeader('Content-Type', 'application/json');

                // Account verisini JSON formatında gönder
                String requestBody = JSON.serialize(new Map<String, Object>){
                    'Name' => acc.Name,
                    'Phone' => acc.Phone,
            
            }
        }
    }