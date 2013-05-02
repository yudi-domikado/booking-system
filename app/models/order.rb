class Order < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :order_at, :user_id, :total, :status
  belongs_to :user
  belongs_to :room
end