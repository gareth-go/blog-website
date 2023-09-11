import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "allNotifications", "postsNotifications", "commentsNotifications", "reactionsNotifications" ]
  static values = { type: String }

  initialize() {
    switch (this.typeValue) {
      case "Post":
        this.postsNotificationsTarget.classList.add("bg-white");
        break;
      case "Comment":
        this.commentsNotificationsTarget.classList.add("bg-white");
        break;
      case "Reaction":
        this.reactionsNotificationsTarget.classList.add("bg-white");
        break;
      default:
        this.allNotificationsTarget.classList.add("bg-white");
    }
  }
}
