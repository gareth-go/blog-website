class CommentPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def destroy?
    user == record.post.user || user&.admin? || user == record.user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
