$(document).on('turbolinks:load', function() {  
  $('.post__main__comments').on('click', '.reply__option__show-replies', function(event) {
    var replies = $(event.target.closest('.reply__option').nextSibling.nextSibling)

    if (replies.hasClass('d-none')) {
      replies.removeClass('d-none')
      $(this).text('Collapse replies')
    } else {
      replies.addClass('d-none')
      $(this).text('Expand replies')
    }
  })

  $('.post__main__comments').on('click', '.toggle-edit-comment-form', function(event) {
    var comment = event.target.closest('.post__main__comments__list__detail') ||
                  event.target.closest('.reply__list__detail')
    var edit_form = comment.nextSibling
    
    $(comment).addClass('d-none')
    $(edit_form).removeClass('d-none')
    $(edit_form).children('textarea').trigger('focus')
  })

  $('.post__main__comments').on('click', '.cancel-edit-comment', function(event) {
    var edit_form = event.target.closest('.post__main__comments__list__edit-form') ||
                    event.target.closest('.reply__list__edit-form')
    var comment = edit_form.previousSibling

    $(edit_form).addClass('d-none')
    $(comment).removeClass('d-none')
  })

  $('.post__main__comments').on('click', '.reply__option__toggle-form', function(event) {
    var button = event.target.closest('.reply__option')
    var reply_form = button.nextSibling

    $(button).addClass('d-none')
    $(reply_form).removeClass('d-none')
    $(reply_form).children('textarea').trigger('focus')
  })

  $('.post__main__comments').on('click', '.cancel-reply-comment', function(event) {
    var reply_form = event.target.closest('.comment__form')
    var button = reply_form.previousSibling

    $(reply_form).addClass('d-none')
    $(button).removeClass('d-none')
  })
})

