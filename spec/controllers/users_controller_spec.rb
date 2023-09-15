require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    it 'success response' do
      get :show, params: { username: user.username }
      should respond_with :success
    end
  end
end
