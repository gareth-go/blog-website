class Dashboard::AccountsController < ApplicationController
  before_action :set_account, except: %i[index]

  def index
    @accounts = User.all.order(status: :desc, role: :desc, id: :asc)

    @accounts = @accounts.where('username LIKE ? OR email LIKE ?',
                                "%#{params[:search] || ''}%",
                                "%#{params[:search] || ''}%")

    @accounts = @accounts.where(status: params[:status]) if User.statuses.include?(params[:status])
    @accounts = @accounts.where(role: params[:role]) if User.roles.include?(params[:role])

    @accounts_count = @accounts.size

    @pagy, @accounts = pagy(@accounts, items: 10)

    if request.xhr? && params[:next_page] == 'true'
      respond_to do |format|
        format.js { render 'next_page' }
      end
    end
  end

  def grant_admin
    @account.update(role: :admin)
    render_update
  end

  def revoke_admin
    @account.update(role: :normal_user)
    render_update
  end

  def ban
    @account.update(status: :banned)
    render_update
  end

  def unban
    @account.update(status: :active)
    render_update
  end

  private

  def set_account
    @account = User.find(params[:id])
  end

  def render_update
    respond_to do |format|
      format.js { render 'update' }
    end
  end
end
