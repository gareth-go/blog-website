module Dashboard::AccountsHelper
  def display_status(account)
    if account.banned?
      content_tag(:div, 'Banned', class: 'text-danger ')
    else
      content_tag(:div, 'Active', class: 'text-success')
    end
  end

  def display_role(account)
    content_tag(:div, 'Admin', class: 'text-primary') if account.admin?
  end
end
