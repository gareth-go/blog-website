module Authentication
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:admin)
  end

  def login_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end
end
