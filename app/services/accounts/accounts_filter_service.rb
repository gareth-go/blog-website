module Accounts
  class AccountsFilterService < ApplicationService
    def initialize(accounts, params)
      @accounts = accounts
      @params = params
    end

    def call
      search
      filter_by_status
      filter_by_role

      @accounts
    end

    private

    def search
      @accounts = @accounts.where('username LIKE ? OR email LIKE ?',
                                  "%#{@params[:search] || ''}%",
                                  "%#{@params[:search] || ''}%")
    end

    def filter_by_status
      @accounts = @accounts.where(status: @params[:status]) if User.statuses.include?(@params[:status])
    end

    def filter_by_role
      @accounts = @accounts.where(role: @params[:role]) if User.roles.include?(@params[:role])
    end
  end
end
