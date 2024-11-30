import { LightningElement } from 'lwc';

export default class ConditionalRendering1 extends LightningElement {
    showContent = true;
    dataIfTrue = "Show this content if true.";
    showIfFalse = 'Show this content if false.';
}