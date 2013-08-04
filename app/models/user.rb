class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, 
                  :remember_me, :department, :phone, :company_id
                  
  has_many :orders
  has_many :room_orders
  belongs_to :company
  belongs_to :role

  default_scope includes(:role, :company).order("users.name ASC")
  delegate :name,  to: :role,    allow_nil: true, prefix: true
  delegate :title, to: :company, allow_nil: true, prefix: true

  scoped_search on: [:name, :email, :phone]
  scoped_search in: :company, on: :title

  scope :newest, order("users.updated_at DESC")

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

  def super_admin?
    role_name.to_s == "super_admin"
  end

  def food_admin?
    role_name.to_s == "food_admin"
  end

  def room_admin?
    role_name.to_s == "room_admin"
  end

  def customer?
    role_name.blank? || role_name.to_s == "customer"
  end

end 
