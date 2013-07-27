class ReferenceCompanyToUsers < ActiveRecord::Migration
  def up
  	add_column    :users, :company_id, :integer
  	remove_column :users, :company
  end

  def down
  	add_column     :users, :company, :string
  	remove_column  :users, :company_id
  end
end
