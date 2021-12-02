class OrderPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     if user.role == "admin"
  #       scope.all
  #     end
  #   end
  # end

  def show?
    is_staff? || is_admin?
  end

  def index?
    is_staff? || is_admin?
  end

  def update?
    is_staff? || is_admin?
  end

  def create?
    is_staff? || is_admin?
  end

  def destroy?
    is_admin?
  end
end
