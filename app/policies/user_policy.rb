class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    user_is_owner_or_admin?
  end

  def create?
    user_is_adnin?
  end

  def update?
    user_is_adnin?
    # - record: the chatroom passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    user_is_adnin?
  end

  private

  def user_is_owner_or_admin?
    record.owner == user || user.admin
  end

  def user_is_adnin?
    user.admin
  end
end
