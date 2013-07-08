class CartItem < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor   :hour_start, :hour_end

  belongs_to :room
  belongs_to :cart
  belongs_to :facility
  belongs_to :company

  before_validation :parse_time
  validate :check_time
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :title
  validates_presence_of :company_id
  before_destroy :facilities

  delegate :title, to: :company, prefix: true, allow_nil: true

  def parse_time
    self.start_time = Time.parse("#{self.check_in_date} #{self.hour_start}").to_i if self.hour_start.present?
    self.end_time = Time.parse("#{self.check_in_date} #{self.hour_end}").to_i if self.hour_end.present?
  end

  private
    def check_time

    	if self.start_time.blank?
        errors.add("Start time", "is invalid")
      end
    	
      if self.end_time.present? && self.end_time < Time.now.to_i
        errors.add("End Time", "should be greater than now")
    	end
    
    	if self.start_time && self.end_time && self.start_time > self.end_time
        errors.add("End Time", "should be greater than Start Time")
    	end

      if OrderItem.where(room_id: self.room_id).
                   where(check_in_date: self.check_in_date).
                   where("(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time > ? AND end_time < ?)", 
                          self.start_time, self.start_time, self.end_time, self.end_time, self.start_time, self.end_time).
                   present?
        self.errors.add("room", "is already used by another company")
      end
    end

    def facilities
      Facility.where("id IN (?)", facility_ids.to_s.split(","))
    end
end
