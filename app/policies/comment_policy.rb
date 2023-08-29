class CommentPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def destroy?
    user&.admin? || user == record.user || user == record.post.user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
