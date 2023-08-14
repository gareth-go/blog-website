$(document).on('turbolinks:load', function() {
  $('.form__content__top__tags__selector').select2({
    allowClear: true,
    placeholder: 'Select a least ont tag...',
    minimumResultsForSearch: 1,
    maximumSelectionLength: 4
  })
  $('.form__content__top__cover_image_input').on('change', previewFile)
  $('#cover-img-review-wrapper').on('click', removeFile)
});

function previewFile() {
  var preview = $('#cover-img-review')
  var file    = $('.form__content__top__cover_image_input')[0].files[0]
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
function removeFile() {
  $('.form__content__top__cover_image_input').val(null)
  $('#cover-img-review').attr('src', '')
}
