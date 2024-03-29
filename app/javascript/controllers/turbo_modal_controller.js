import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  connect() {
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src");
    console.log("hideModal");
    this.element.remove();
  }

    // hide modal on successful form submission
  // action: "turbo:submit-end->turbo-modal#submitEnd"
  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
  }
}
