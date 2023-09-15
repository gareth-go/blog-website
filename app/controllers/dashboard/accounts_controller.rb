class Dashboard::AccountsController < ApplicationController
  before_action :set_account, except: %i[index]

  before_action :authenticate_user!

  def index
    @accounts = policy_scope([:dashboard, User]).all.order(status: :desc, role: :desc, id: :asc)
    @accounts = Accounts::AccountsFilterService.call(@accounts, params)
    @accounts_count = @accounts.size

    @pagy, @accounts = pagy(@accounts, items: 10)

    if request.xhr? && params[:next_page] == 'true'
      respond_to do |format|
        format.js { render 'next_page' }
      end
    end
  end

  def update
    authorize [:dashboard, @account]

    @account.update(role: params[:role]) if User.roles.include?(params[:role])
    @account.update(status: params[:status]) if User.statuses.include?(params[:status])
  end

  private

  def set_account
    @account = User.find(params[:id])
  end
end
