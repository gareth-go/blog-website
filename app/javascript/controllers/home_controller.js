import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = [ "lastestLink", "topCommentsLink", "topReactionsLink", "followingLink" ]
  static values = { sort: String, filter: String }

  initialize() {
    if (this.sortValue != "comments" && this.sortValue != "reactions" && this.filterValue != 'following') this.lastestLinkTarget.classList.add("active")
    if (this.sortValue == "comments") this.topCommentsLinkTarget.classList.add("active")
    if (this.sortValue == "reactions") this.topReactionsLinkTarget.classList.add("active")
    if (this.filterValue == 'following') this.followingLinkTarget.classList.add("active")
  }
}
