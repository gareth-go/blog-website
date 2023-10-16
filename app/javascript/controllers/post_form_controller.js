import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post-form"
export default class extends Controller {
  static targets = [ "imageInput", "imageReview", "tagsSelector", "removeImageCheckbox", "form" ]
  static values = { type: String }

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

    if (this.typeValue == "new")
      this.save() 
  }

  removeFile() {
    $(this.imageInputTarget).val(null)
    $(this.imageReviewTarget).attr("src", "")
    $(this.removeImageCheckboxTarget).prop("checked", true)

    if (this.typeValue == "new")
      this.save() 
  }

  save() {
    const params = new FormData(this.element)

    $.ajax({
      url: "/save",
      method: "put",
      data: params,
      processData: false,
      contentType: false,
      success: function (data) {
        if (data.errors) {
          console.log('error')
        }
      },
      error: function(xhr, textStatus, errorThrown) {
        console.log("Error:", errorThrown);
      }
    })
  }
}
