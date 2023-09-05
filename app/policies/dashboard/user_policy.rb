class Dashboard::UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user.admin?

      scope.all
    end
  end

  def update?
    user.admin?
  end
end
