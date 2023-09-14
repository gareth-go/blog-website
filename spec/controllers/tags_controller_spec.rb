require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:tag) { FactoryBot.create(:tag) }

  describe 'GET #index' do
    it 'success response' do
      get :index
      should respond_with :success
    end
  end

  describe 'GET #show' do
    it 'success response' do
      get :show, params: { name: tag.name }
      should respond_with :success
    end
  end
end
