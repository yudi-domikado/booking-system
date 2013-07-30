class Cart < ActiveRecord::Base
  attr_accessible :session_id , :price
  after_create :add_watcher

  def self.table_name_prefix
    self.to_s == "Cart" ? '' : 'cart_'
  end

  def delete_expired
    if self.updated_at < 30.minutes.ago
      self.destory
    else
      add_watcher
    end
  end

  private
    def add_watcher
      self.delay_for(30.minutes).delete_expired
    end
end