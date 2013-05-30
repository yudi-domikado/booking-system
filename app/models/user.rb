class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, 
                  :company, :department, :phone
  # attr_accessible :title, :body
  has_many :orders
  has_many :carts
  has_many :rooms
  has_many :topups
  has_many :events
end
