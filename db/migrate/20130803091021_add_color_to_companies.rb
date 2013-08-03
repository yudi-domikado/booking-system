class AddColorToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :color, :string
  end
end
