class Settings::UserPolicy < ApplicationPolicy
  def edit?
    user == record
  end

  def update?
    user == record
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
