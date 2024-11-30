import { LightningElement } from 'lwc';

export default class MyRoleHomework extends LightningElement {
    username;
    role;

    changeHandlerUn(event){
        this.username = event.target.value;
    }

    changeHandlerRole(event){
        this.role = event.target.value;
    }
}