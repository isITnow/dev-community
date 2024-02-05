import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="disable-end-date"
export default class extends Controller {
  connect() {
    this.disableEndDate();
  }

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->disable-end-date#disableEndDate"
    );
  }

  disableEndDate() {
    const endDateEl = document.querySelector("#work_experience_end_date");

    if (this.element.checked) {
      endDateEl.value = null;
      endDateEl.setAttribute("disabled", true);
    } else {
      endDateEl.removeAttribute("disabled");
    }
  }
}
