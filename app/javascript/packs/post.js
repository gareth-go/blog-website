$(document).on('turbolinks:load', function() {
  $('.post__option__reation__menu__item').on('click', toggle_reaction)
})

function toggle_reaction() {
  active_reaction = $('.reaction-active')
  reaction_type = this.id

  var action
  var method

  if (active_reaction.length == 0) {
    action = 'add'
    method = 'post'
  } else
    if (active_reaction[0].id == reaction_type) {
      action = 'remove'
      method = 'delete'
      active_reaction.removeClass('.reaction-active')
    } else {
      action = 'change'
      method = 'put'
      active_reaction.removeClass('.reaction-active')
    }

  url = window.location.pathname + `/${action}-reaction?reaction_type=${reaction_type}`

  $.ajax({
    url,
    method,
    dataType: 'script',
    success: function (data) {
      if (data.errors) {
        console.log('error')
      } else {
        $('.post__option__reation__menu__item').on('click', toggle_reaction)
      }
    },
    error: function(xhr, textStatus, errorThrown) {
      console.log("Error:", errorThrown);
    }
  })
}


