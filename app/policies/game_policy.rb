class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def add_genre?
    update?
  end

  def add_platform?
    update?
  end

  def remove_genre?
    update?
  end

  def remove_platform?
    update?
  end
end
