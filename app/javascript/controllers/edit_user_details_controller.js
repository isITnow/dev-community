import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="edit-user-details"
export default class extends Controller {
  connect() {}

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->edit-user-details#showModal"
    );
  }

  showModal(e) {
    e.preventDefault();
    this.url = this.element.getAttribute("href");
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then((resp) => resp.text())
      .then((html) => Turbo.renderStreamMessage(html))
      .catch((err) => console.error(err.message));
  }
}
