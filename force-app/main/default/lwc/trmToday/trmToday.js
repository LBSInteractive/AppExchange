import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getTrmService from '@salesforce/apex/trmService.getTrmService';

export default class TrmToday extends LightningElement {

    /* ------------------------------------------------------------------------------------------
    | Scopes
    -------------------------------------------------------------------------------------------- */
    @track $VIEW = {
        card:{
            buttons:{
                refresh:false
            }
        }
    };


    /* ------------------------------------------------------------------------------------------
    | Wires
    -------------------------------------------------------------------------------------------- */
    @wire(getTrmService) trmString;


    /* ------------------------------------------------------------------------------------------
    | Actions
    -------------------------------------------------------------------------------------------- */
    $EVENT = {
        refreshData: ()=>{
            this.$VIEW.card.buttons.refresh = true;
            refreshApex(this.trmString);
            setTimeout(() => {
                this.$VIEW.card.buttons.refresh = false;
            }, 1000);
        }
    }
    
    
    /* ------------------------------------------------------------------------------------------
    | Complex
    -------------------------------------------------------------------------------------------- */
    
}