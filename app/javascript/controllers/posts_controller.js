import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = [ "comments", "coverImage" ]

  initialize() {
    if (window.location.hash == "#comments") {
      this.coverImageTarget.onload = () => {
        this.commentsTarget.scrollIntoView(true, { behavior: "smooth" })
      }
    }
  }

  scrollToComments() {
    this.commentsTarget.scrollIntoView(true, { behavior: "smooth" })
  }
}
