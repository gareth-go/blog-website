import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  copyLink() {
    navigator.clipboard.writeText(document.URL)
  }
}
