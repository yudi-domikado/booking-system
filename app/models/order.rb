class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :code, use: :slugged

  attr_accessible :user_id, :ammount, :slug
  belongs_to :user
  before_create :before_creation

  scoped_search on: [:code, :amount, :order_at, :amount, :type]
  scoped_search in: :user, on: [:name, :email], ext_method: :find_by_company_name
  
  scope :newest_orders, order("orders.order_at DESC")
  scope :pendings, where("orders.status = ?", "pending")
  
  default_scope includes(:user)
  delegate :name, to: :user, prefix: true, allow_nil: true
  

  module Status
  	PENDING = "pending"
  	CANCELED = "canceled"
  	APPROVED = "approved"
  end

  def self.statuses
    [
      [Status::PENDING.titleize, Status::PENDING],
      [Status::CANCELED.titleize, Status::CANCELED],
      [Status::APPROVED.titleize, Status::APPROVED]
    ]
  end

  def self.find_by_company_name(key, operator, value)
    companies = Company.where("title LIKE ?", "%#{value}%").map(&:id)
    users = User.where("id IN (?)", companies).map(&:id)
    return {conditions: "orders.user_id IS NOT NULL"} if users.blank?
    { :conditions => "orders.user_id IN(#{users.join(',')})" } 
  end
  
  def self.table_name_prefix
    self.to_s == "Order" ? '' : 'order_'
  end

  def self.order_histories(user)
    return newest_orders.where(user_id: user.id) if user.customer?
    newest_orders
  end

  def pending?
    self.status == Status::PENDING || self.status.blank?
  end

  def approved?
    self.status == Status::APPROVED
  end

  def canceled?
    self.status == Status::CANCELED
  end

  private
    def before_creation
      self.code = generate_code
      while(self.class.find_by_code(self.code).present?)
        self.code = generate_code
      end
      self.status = Order::Status::PENDING if self.status.blank?
      self.order_at = Time.now
    end

    def generate_code
      self.code_number = total_order
      Date.today.strftime("%d%m%Y/#{user.company_title.upcase}/R") + "%04d" % self.code_number
    end

    def total_order
      start_at = Time.now.at_beginning_of_month.midnight
      result =  self.class.where("order_at > ? AND order_at <= ?", start_at, start_at.at_end_of_month).
                order("code_number DESC").first
      return 1 unless result
      result.code_number.to_i + 1
    end
end