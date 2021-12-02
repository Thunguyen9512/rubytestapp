class UserPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     if user.role == "admin"
  #       scope.all
  #     end
  #   end
  # end
  def update?
    is_admin?
  end

  def show?
    is_admin?
  end

  def index?
    is_admin?
  end

  def update?
    is_admin?
  end

  def create?
    is_admin?
  end

  def destroy?
    is_admin
  end
end
