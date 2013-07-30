class Order < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :user_id, :ammount
  belongs_to :user
  before_create :before_creation

  scoped_search on: [:code, :amount, :order_at, :amount, :type]
  scoped_search in: :user, on: [:name, :email]
  scoped_search in: :user, on: {company: :title}
  
  scope :newest_orders, order("order_at DESC")
  scope :pendings, where(status: "pending")
  friendly_id :code, use: :slugged

  delegate :name, to: :user, prefix: true, allow_nil: true
  

  module Status
  	PENDING = "pending"
  	CANCELED = "canceled"
  	APPROVED = "approved"
  end
  
  def self.table_name_prefix
    self.to_s == "Order" ? '' : 'order_'
  end

  def self.order_histories(user)
    return newest_orders.where(user_id: user.id) if user.customer?
    newest_orders
  end

  private
    def before_creation
      self.code = generate_code
      while(self.class.find_by_code(self.code).present?)
        self.code = generate_code
      end
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