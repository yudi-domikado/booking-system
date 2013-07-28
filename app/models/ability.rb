class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin
      manage :all
    else
      can [:read, :update, :profile], User, id: user.id
      cannot :index, User
      can [:create]
      can [:read, :update, :destroy], Order, user_id: user.id
      can :all, OrderItem do |order_item|
        Order.where(user_id: user.id, order_id: order_item.order_id).present?
      end
    end
    
  end
end
