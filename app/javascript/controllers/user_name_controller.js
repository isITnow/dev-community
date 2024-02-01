import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="user-name"
export default class extends Controller {
  static targets = ["name"];

  connect() {
    // console.log(window);
  }

  getUserName = () => {
    const el = this.nameTarget;
    const name = el.textContent;
    // alert("User name: " + name);
    console.log(window);
  };
}
