public class FlightTracker {
    public static String getFlightData(String flightNumber) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://static.flightaware.com/rsrc/aeroapi/aeroapi-openapi.yml' + flightNumber);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer x-apikey');

        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            throw new CalloutException('API call failed: ' + response.getStatus());
        }
    }
    public class FlightData {
        public String ident;
        public String origin;
        public String destination;
        public String filed_departure_time;
        public String estimated_arrival_time;
        public String terminal;
        public String gate;
    }
}
