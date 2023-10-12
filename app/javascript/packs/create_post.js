$(document).on('turbo:load', function() {
  $('.form__content__top__tags__selector').select2({
    placeholder: 'Select a least ont tag...',
    maximumSelectionLength: 4
  })
  $('.form__content__top__cover__image__input').on('change', previewFile)
  $('#cover-img-review-wrapper').on('click', removeFile)
});

function previewFile() {
  var preview = $('#cover-img-review')
  var file    = $('.form__content__top__cover__image__input')[0].files[0]
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
