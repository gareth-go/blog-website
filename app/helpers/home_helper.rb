module HomeHelper
  def cover_image_if_first_post(page, post, is_first_posts)
    image_tag(post.cover_image, class: 'w-100 rounded-top shadow-sm') if controller_name == 'home' &&
                                                                         page.present? &&
                                                                         page == 1 &&
                                                                         is_first_posts &&
                                                                         post.cover_image.attached?
  end
end
