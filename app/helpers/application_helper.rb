# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def share_button(url, text, tag_class='')
    content_tag :div, class: "btn-group dropend #{tag_class}", data: { controller: 'share' } do
      concat(content_tag(:div,
                         image_pack_tag('media/images/share-icon.svg', class: 'mx-auto'),
                         type: 'button',
                         data: { bs_toggle: 'dropdown' }, aria: { expanded: 'false' }))
      concat(content_tag(:ul, class: 'post__option__share__menu dropdown-menu dropdown-menu-end') do
        concat(content_tag(:li) do
          content_tag(:div, "Copy #{text} link", class: 'dropdown-item menu-link text-decoration-none',
                                                 data: { action: 'click->share#copyLink' }, type: 'button')
        end)
        concat(content_tag(:li) do
          link_to "Share #{text} to Facebook",
                  "https://www.facebook.com/sharer/sharer.php?u=#{url}",
                  target: '_blank',
                  class: 'dropdown-item menu-link text-decoration-none'
        end)
        concat(content_tag(:li) do
          link_to "Share #{text} to Twitter",
                  "http://twitter.com/intent/tweet?url=#{url}",
                  target: '_blank',
                  class: 'dropdown-item menu-link text-decoration-none'
        end)
      end)
    end
  end
end
