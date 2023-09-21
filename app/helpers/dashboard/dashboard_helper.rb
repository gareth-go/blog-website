module Dashboard::DashboardHelper
  def sidebar_tags
    if controller_name == 'tags'
      content_tag(:span,
                  class: 'btn menu-link border-0 text-start text-decoration-none text-reset bg-white d-flex') do
        concat('Tags')
        concat(content_tag(:span,
                           @tags.size,
                           class: 'dashboard__body__sidebar__tags__count rounded ms-auto px-1'))
      end
    else
      link_to 'Tags',
              dashboard_tags_path,
              class: 'btn menu-link border-0 text-start text-decoration-none text-reset d-flex'
    end
  end

  def sidebar_accounts
    if controller_name == 'accounts'
      content_tag(:span,
                  class: 'btn menu-link border-0 text-start text-decoration-none text-reset bg-white d-flex') do
        concat('Accounts')
        concat(content_tag(:span,
                           @accounts_count,
                           class: 'dashboard__body__sidebar__tags__count rounded ms-auto px-1'))
      end
    else
      link_to 'Accounts',
              dashboard_accounts_path,
              class: 'btn menu-link border-0 text-start text-decoration-none text-reset d-flex'
    end
  end
end
