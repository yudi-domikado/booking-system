class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.attachment :logo

      t.timestamps
    end
  end
end
