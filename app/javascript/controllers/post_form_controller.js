import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-form"
export default class extends Controller {
  static targets = [ "imageInput", "imageReview", "tagsSelector", "removeImageCheckbox" ]

  initialize() {
    $(this.tagsSelectorTarget).select2({
      placeholder: "Select a least ont tag...",
      maximumSelectionLength: 4
    })
  }

  previewFile() {
    var preview = $(this.imageReviewTarget)
    var file    = this.imageInputTarget.files[0]
    var reader  = new FileReader();

    reader.onloadend = function () {
      preview.attr('src', reader.result)
    }

    if (file) {
      reader.readAsDataURL(file)
    } else {
      preview.attr('src', '')
    }
  }

  removeFile() {
    $(this.imageInputTarget).val(null)
    $(this.imageReviewTarget).attr("src", "")
    $(this.removeImageCheckboxTarget).prop("checked", true)
  }
}
