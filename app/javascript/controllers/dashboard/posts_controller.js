import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--posts"
export default class extends Controller {
  static targets = [ "allLink", "acceptedLink", "pendingLink", "rejectedLink" ]
  static values = { status: String }

  initialize() {
    if (this.statusValue != "accepted" && this.statusValue != "pending" && this.statusValue != "rejected") this.allLinkTarget.classList.add("active")
    if (this.statusValue == "accepted") this.acceptedLinkTarget.classList.add("active")
    if (this.statusValue == "pending") this.pendingLinkTarget.classList.add("active")
    if (this.statusValue == "rejected") this.rejectedLinkTarget.classList.add("active")
  }
}
