$(document).on('turbolinks:load', function() {
  $('#cover-img-review-wrapper').on('click', function() {
    $('#post_remove_cover_image').prop('checked', true)
  })
})
