require 'rails_helper'

RSpec.describe Dashboard::AccountsHelper, type: :helper do
  describe '#display_status' do
    context 'when the account is banned' do
      it 'displays "Banned" with text-danger class' do
        account = double('Account', banned?: true)
        result = helper.display_status(account)
        expect(result).to have_selector('div.text-danger', text: 'Banned')
      end
    end

    context 'when the account is not banned' do
      it 'displays "Active" with text-success class' do
        account = double('Account', banned?: false)
        result = helper.display_status(account)
        expect(result).to have_selector('div.text-success', text: 'Active')
      end
    end
  end

  describe '#display_role' do
    context 'when the account is an admin' do
      it 'displays "Admin" with text-primary class' do
        account = double('Account', admin?: true)
        result = helper.display_role(account)
        expect(result).to have_selector('div.text-primary', text: 'Admin')
      end
    end

    context 'when the account is not an admin' do
      it 'does not display anything' do
        account = double('Account', admin?: false)
        result = helper.display_role(account)
        expect(result).to be_nil
      end
    end
  end
end
