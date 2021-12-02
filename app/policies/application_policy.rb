# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  private

  def is_reader?
    if user.role == "reader"
      return true
    end
    return false
  end

  def is_staff?
    if user.role == "staff"
      return true
    end
    return false
  end

  def is_admin?
    if user.role == "admin"
      return true
    end
    return false
  end
end
