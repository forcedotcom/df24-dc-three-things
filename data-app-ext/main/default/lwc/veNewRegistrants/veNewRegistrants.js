import { LightningElement, api } from "lwc";
import getParticipantsByRecordId from '@salesforce/apex/VolunteerEventParticipantService.getParticipantsByRecordId';

export default class VeNewRegistrants extends LightningElement {
  @api recordId;
  results;
  errors;

  async connectedCallback() {
    console.log('record id: ' + this.recordId);
    this.results = await getParticipantsByRecordId({ recordId: this.recordId });
    this.errors = this.results.errors;
    console.log(this.results);
  }
  
}
