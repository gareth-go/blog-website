module BookMarksHelper
  def link_to_bookmark(path, method)
    icon_path = if method == :post
                  'media/images/save-icon.svg'
                else
                  'media/images/unsave-icon.svg'
                end

    content_tag :div, class: 'bookmark-button' do
      link_to path, method: method, remote: true do
        image_pack_tag icon_path, class: 'mx-auto'
      end
    end
  end
end
