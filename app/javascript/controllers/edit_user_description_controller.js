import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="edit-user-description"
export default class extends Controller {
  connect() {
    console.log("Connected edit-user-description");
  }

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->edit-user-description#showModal"
    );
  }

  showModal(e) {
    e.preventDefault();
    this.url = this.element.getAttribute("href");
    console.log(this.url);
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
