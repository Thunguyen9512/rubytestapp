class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "admin"
        scope.all
      end
    end
  end
  def update?
    is_staff?
  end

  def show?
    is_staff?
  end

  def index?
    is_staff?
  end

  def update?
    is_staff?
  end

  def create?
    is_staff?  
  end

  def destroy?
    is_staff?
  end
end
