import { LightningElement, track } from 'lwc';
import getFlightData from '@salesforce/apex/FlightTracker.getFlightData';

export default class FlightTracker extends LightningElement {
    @track flightNumber = '';
    @track flightData;

    handleInputChange(event) {
        this.flightNumber = event.target.value;
    }

    handleTrackFlight() {
        getFlightData({ flightNumber: this.flightNumber })
            .then(result => {
                this.flightData = result;
            })
            .catch(error => {
                console.error(error);
            });
    }
}
