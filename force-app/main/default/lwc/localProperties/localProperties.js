import { LightningElement } from 'lwc';

export default class LocalProperties extends LightningElement {
    name; //undefined
    fullName = "Esranur";
    age = 38;
    location = {
        city: "Istanbul",
        country: "Turkiye",
        postalCode: "34080"
    };
    fruits = ["banana", "apple", "plum"];

}