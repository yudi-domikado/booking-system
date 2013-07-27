class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, 
                  :department, :phone, :company_id
  # attr_accessible :title, :body
  has_many :orders
  has_many :carts
  has_many :rooms
  has_many :topups
  has_many :events
  belongs_to :company

  with_options(on: :update) do |update|
    update.with_options(presence: true) do |presence|
      presence.validates :name
      presence.validates :department
      presence.validates :phone
      presence.validates :company_id
    end
  end

  def complete_profile?
    company.present? && department.present?
  end
end
