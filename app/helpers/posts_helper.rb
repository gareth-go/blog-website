module PostsHelper
  def empty_list(filter)
    content_tag(:div, class: 'pt-3') do
      concat(
        content_tag(:h4, class: 'fw-bold text-center') do
          filter ? 'Not thing with this filter' : 'Your reading list is empty'
        end
      )
      concat(
        content_tag(:p, class: 'text-secondary text-center px-2') do
          concat(content_tag(:span, 'Click the '))
          concat(content_tag(:span, 'bookmark reaction', class: 'fw-bold'))
          concat(content_tag(:span, ' when viewing a post to add it to your reading list.'))
        end
      )
    end
  end

  def edit_post_link(post)
    if request.path.include?(post_path(post))
      link_to 'Edit', edit_post_path(post), class: 'menu-link text-decoration-none dropdown-item'
    else
      link_to 'Edit', edit_post_path(post), data: { turbo_frame: :_top }, class: 'menu-link text-decoration-none dropdown-item'
    end
  end
end
