import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-tags"
export default class extends Controller {
  static targets = [ "editForm", "addForm", "tagName", "toggleEditButton", "toggleAddButton" ]

  toggleEdit() {
    if ($(this.editFormTarget).hasClass("d-none")) {
      this.toggleEditButtonTarget.disabled = true
      $(this.editFormTarget).removeClass("d-none")
      $(this.editFormTarget).children(".tag-name-input").trigger("focus")
      $(this.tagNameTarget).addClass("d-none")
    } else {
      this.toggleEditButtonTarget.disabled = false
      $(this.editFormTarget).addClass("d-none")
      $(this.tagNameTarget).removeClass("d-none")
    }
  }

  toggleAdd() {
    if ($(this.addFormTarget).hasClass("d-none")) {
      $(this.addFormTarget).removeClass("d-none")
      $(this.addFormTarget).children(".tag-name-input").trigger("focus")
      $(this.toggleAddButtonTarget).addClass("d-none")
    } else {
      $(this.addFormTarget).addClass("d-none")
      $(this.addFormTarget).children(".tag-name-input").val("")
      $(this.addFormTarget).children(".dashboard__body__table__add-form__error")[0].innerHTML = ""
      $(this.toggleAddButtonTarget).removeClass("d-none")
    }
  }
}
