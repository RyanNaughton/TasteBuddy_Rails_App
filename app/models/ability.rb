class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      if user.persisted?
        can :create, Restaurant::Comment
        can :create, Restaurant::Menu::Item::Comment
        can :create, :pictures
        can :manage, Picture, :user_id => user.id
      end
      can :read, :all
    end
  end
end
