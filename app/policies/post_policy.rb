class PostPolicy < ApplicationPolicy
  def show?
    record.accepted? || user&.admin? || user == record.user
  end

  def update?
    user == record.user
  end

  def destroy?
    user&.admin? || user == record.user
  end

  def accept?
    record.pending? && user&.admin?
  end

  def reject?
    record.pending? && user&.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
