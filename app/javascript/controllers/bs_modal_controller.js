import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    console.log("Connected bs-modal");
    this.modal = new bootstrap.Modal(this.element, {
      keyboard: false,
    });
    this.modal.show();
  }

  disconnect() {
    this.modal.hide();
  }

  submitEnd(e) {
    this.modal.hide();
  }
}