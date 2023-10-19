# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  include Pundit::Authorization

  def display_alert(message, type)
    content_tag(:div,
                class: "alert alert-#{type} alert-dismissible fade show position-absolute start-0 bottom-0 ms-2 d-inline-block position-fixed",
                role: 'alert') do
      concat(button_tag('',
                        class: 'btn-close',
                        type: 'button',
                        data: { bs_dismiss: 'alert' },
                        aria: { label: 'Close' }))
      concat(message)
    end
  end

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

  def set_dashboard_meta_tags
    set_meta_tags(title: 'Dashboard',
                  description: 'BLOG Community is a blog platform for people to share the post and interact with each other.',
                  keywords: 'blog community, blog website, blog',
                  og: { image: 'https://res.cloudinary.com/dcsoijeug/image/upload/v1696324234/site-image_kiey7w.jpg' })
  end

  def set_settings_meta_tag
    set_meta_tags(title: 'Settings',
                  description: 'Settins your account in BLOG Community. BLOG Community is a blog platform for people to share the post and interact with each other.',
                  keywords: 'blog community, settings, blog website, blog',
                  og: { image: 'https://res.cloudinary.com/dcsoijeug/image/upload/v1696324234/site-image_kiey7w.jpg' })
  end
end
