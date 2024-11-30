import { LightningElement, track } from 'lwc';

export default class TrackProperty extends LightningElement {
    @track location = {
        city: "Delmar",
        country: "US"
    };

    changeHandler(event){
        this.location.city = event.target.value;
    }
}