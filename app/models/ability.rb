# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    if user.role_id && user.role.role_name == 'admin'
      can :manage, :all
    else
      can :read, Movie
      can :index, MovieShow # Grant :index ability for MovieShow
      can :index, Theater
      can :create, Ticket, user_id: user.id
      can :show, User, id: user.id
      can :destroy, User, id: user.id
    end
  end
end
