import { LightningElement } from 'lwc';

export default class GettersComponent extends LightningElement {
    num1 = 10;
    num2 = 20;

    values = [10, 20, 30, 40, 50];

    get midValue(){
        const mid = this.values.length/2;
        return this.values[Math.floor(mid)];
    }
}