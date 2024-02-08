import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="update-connection-status"
export default class extends Controller {
  connect() {}

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->update-connection-status#updateConnectionStatus"
    );
  }

  async updateConnectionStatus(e) {
    e.preventDefault();

    this.url = this.element.getAttribute("href");

    const connectionBody = new FormData();

    const newStatus =
      this.element.textContent === "Accept" ? "accepted" : "rejected";

    connectionBody.append("connection[status]", newStatus);

    try {
      const resp = await fetch(this.url, {
        method: "PATCH",
        headers: {
          Accept: "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
        body: connectionBody,
      });
      const html = await resp.text();
      Turbo.renderStreamMessage(html);
    } catch (err) {
      console.error(err.message);
    }
  }
}
