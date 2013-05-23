class AddUnlimitedToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :unlimited, :boolean
  end
end
