public class OAuthTokenFetcher {
    // Salesforce OAuth 2.0 Token Endpoint
    private static final String TOKEN_URL = 'https://littlecake-dev-ed.develop.my.salesforce.com/';

    // Connected App bilgileriniz
    private static final String CLIENT_ID = '3MVG9JJwBBbcN47Jsvjrus_jsoeL5wh5.xskm5KyeMxM4dcjm48fHTpoJY7j7AQ1RP9GgV0uO74rz3YFysscL';
    private static final String CLIENT_SECRET = 'FF66271E675D5C9BA6D01295B8B8131C08E583D2927A4726CF504D5ED22A482C';
    
    public static String getAccessToken() {
        // Access Token alma işlemi için HTTP isteği oluşturma
        HttpRequest req = new HttpRequest();
        req.setEndpoint(TOKEN_URL);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        // Body parametrelerini ayarlama
        String requestBody = 'grant_type=client_credentials'
            + '&client_id=' + CLIENT_ID
            + '&client_secret=' + CLIENT_SECRET;
        req.setBody(requestBody);

        // HTTP isteğini gönderme
        Http http = new Http();
        HttpResponse res = http.send(req);

        // Access Token alma
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (String) responseMap.get('access_token');
        } else {
            System.debug('Failed to get access token. Response: ' + res.getBody());
            throw new OAuthException('Failed to authenticate with target org');
        }
    }

    // Hata yönetimi için özel exception
    public class OAuthException extends Exception {}
}
