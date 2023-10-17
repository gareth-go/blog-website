require 'rails_helper'

RSpec.describe Dashboard::DashboardHelper, type: :helper do
  describe '#sidebar_tags' do
    context 'when on the tags controller' do
      before do
        assign(:tags, 8)
        allow(helper).to receive(:controller_name).and_return('tags')
      end

      it 'renders the Tags menu item with count' do
        content = helper.sidebar_tags

        expect(content).to have_selector('span', text: 'Tags')
        expect(content).to have_selector('span.dashboard__body__sidebar__tags__count', text: '8')
        expect(content).to have_css('.bg-white')
      end
    end

    context 'when not on the tags controller' do
      before do
        allow(helper).to receive(:controller_name).and_return('other_controller')
      end

      it 'renders a link to the Tags controller' do
        content = helper.sidebar_tags

        expect(content).to have_link('Tags', href: dashboard_tags_path)
        expect(content).not_to have_css('.bg-white')
      end
    end
  end

  describe '#sidebar_accounts' do
    context 'when on the accounts controller' do
      before do
        allow(helper).to receive(:controller_name).and_return('accounts')
        assign(:accounts_count, 10)
      end

      it 'renders the Accounts menu item with count' do
        content = helper.sidebar_accounts

        expect(content).to have_selector('span', text: 'Accounts')
        expect(content).to have_selector('span.dashboard__body__sidebar__tags__count', text: '10')
        expect(content).to have_css('.bg-white')
      end
    end

    context 'when not on the accounts controller' do
      before do
        allow(helper).to receive(:controller_name).and_return('other_controller')
      end

      it 'renders a link to the Accounts controller' do
        content = helper.sidebar_accounts

        expect(content).to have_link('Accounts', href: dashboard_accounts_path)
        expect(content).not_to have_css('.bg-white')
      end
    end
  end
end
