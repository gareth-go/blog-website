module HomeHelper
  def cover_image_if_first_post(page, post, first_posts)
    image_tag(post.cover_image, class: 'w-100 rounded-top shadow-sm') if page.present? &&
                                                                         page == 1 &&
                                                                         post == first_posts &&
                                                                         post.cover_image.attached?
  end
end
