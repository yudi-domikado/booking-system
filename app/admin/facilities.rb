ActiveAdmin.register Facility do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :price
      f.input :description
   end
   f.actions
  end

  index do |c|
  	c.column :name
  	c.column :price do |currency|
      number_to_currency(currency.price, unit: "Rp.", format: "%u %n")
    end
    c.column :description
  end
end
