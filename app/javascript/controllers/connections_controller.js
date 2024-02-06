import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="connections"
export default class extends Controller {
  static targets = ["connection"];

  connect() {}

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->connections#prepareConnectionParams"
    );
  }

  async prepareConnectionParams(e) {
    e.preventDefault();

    this.url = this.element.getAttribute("href");
    const element = this.connectionTarget;
    const requesterId = element.dataset.requesterId;
    const connectedId = element.dataset.connectedId;

    const connectionBody = new FormData();
    connectionBody.append("connection[user_id]", requesterId);
    connectionBody.append("connection[connected_user_id]", connectedId);
    connectionBody.append("connection[status]", "pending");

    try {
      const resp = await fetch(this.url, {
        method: "POST",
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
