import { LightningElement } from 'lwc';

export default class ConditionalRendering2 extends LightningElement {
    showData = true;
    details = {
        fullName: "Esranur Bozdemir",
        place: "Selkirk"
    };
    
    clickHandler(){
        this.showData = !this.showData;

    }
}