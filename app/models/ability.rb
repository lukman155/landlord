# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    else
      can :read, Property
      can :read, Rental, renter_id: user.id
    end
  end
end
