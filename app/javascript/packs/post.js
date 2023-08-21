$(document).on('turbolinks:load', function() {
  $('a.post__option__reation__menu__item__link').on('click', toggle_reaction)
})

function toggle_reaction() {
  var url = $(this).attr('href')
  var method = $(this).attr('data-method')

  $.ajax({
    url,
    method,
    dataType: 'script',
    success: function (data) {
      if (data.errors) {
        console.log('error')
      } else {
        $('a.post__option__reation__menu__item__link').on('click', toggle_reaction)
      }
    },
    error: function(xhr, textStatus, errorThrown) {
      console.log("Error:", errorThrown);
    }
  })

  return false
}


