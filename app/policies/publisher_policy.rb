class PublisherPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
  def show?
    return true
  end

  def index?
    return true
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
