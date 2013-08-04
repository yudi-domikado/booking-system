class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :code, use: :slugged

  attr_accessible :user_id, :ammount, :slug
  cattr_accessor :search_type
  belongs_to :user
  before_create :before_creation

  scoped_search on: [:code, :amount, :order_at, :type, :status]
  scoped_search in: :user, on: [:name, :email], ext_method: :custom_search
  
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

  def self.custom_search(key, operator, value)

    companies = Company.where("title LIKE ?", "%#{value}%").map(&:id)
    user_queries = ["users.name LIKE ?", "users.email LIKE ?"]
    user_queries.push("id IN (?)") if companies.present?
    user_queries = [user_queries.join(' OR '), "%#{value}%", "%#{value}%"]
    user_queries.push(companies) if companies.present? 
    user_ids = User.where(user_queries).map(&:id)

    arr_queries = []
    
    unless user_ids.blank?
      arr_queries.push("orders.user_id IN(#{user_ids.join(',')})")
    end
    
    if self.search_type == "RoomOrder"
      room_ids = Room.where("name LIKE ?", "%#{value}%").map(&:id)
      order_ids = Order::RoomItem.
                         where("room_id IN (?)", room_ids).
                         map(&:room_order_id).uniq if room_ids.present?
      
      unless order_ids.blank?
        arr_queries.push("orders.id IN(#{order_ids.join(',')})")
      end
    end
    
    if arr_queries.blank?
      arr_queries.push("orders.user_id IS NULL") 
    end

    
    {conditions: arr_queries.uniq.compact.join(' OR ')}

  end
  
  def self.table_name_prefix
    self.to_s == "Order" ? '' : 'order_'
  end

  def self.order_histories(user, _type="")
    self.search_type = _type
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