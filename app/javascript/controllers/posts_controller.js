import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = [ "comments", "coverImage" ]

  initialize() {
    if (window.location.hash == "#comments") {
      this.coverImageTarget.onload = () => {
        this.commentsTarget.scrollIntoView(true, { behavior: "smooth" })
      }
    } else {
      let comment = document.querySelector(window.location.hash)
      if (comment) {
        comment.querySelector(".comment-detail").classList.add("bg-light", "rounded")
        this.coverImageTarget.onload = () => {
          comment.scrollIntoView(true, { behavior: "smooth" })
        }
      }
    }
  }

  copyLink() {
    navigator.clipboard.writeText(document.URL)
  }

  scrollToComments() {
    this.commentsTarget.scrollIntoView(true, { behavior: "smooth" })
  }
}
