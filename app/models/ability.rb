class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_admin?
      manage :all
    else
      %w(User Room Order Company Facility RoomOrder).each do |model|
        cannot :all, model.constantize
      end
      can [:read, :update, :profile], User, id: user.id
      cannot :index, User
      can [:create]
      can [:read, :update, :destroy], Order, user_id: user.id

      can :all, Order::RoomItem do |order_item|
        RoomOrder.where(user_id: user.id, order_id: order_item.order_id).present?
      end

      can :all, RoomOrder, user_id: user.id
    end
    
  end
end
