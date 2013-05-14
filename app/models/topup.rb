class Topup < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :credit, :topup_date
  belongs_to :user
  validates :credit, :numericality => {:only_integer => true, :greater_than => 0}
  validates :user, :presence => true
  validate :check_date

  def check_date
  	if topup_date.present?
  	  if topup_date > Date.today
  	    errors.add("Top up date", "cannot greater than today")
  	  end
  	end
  end
end
