ActiveAdmin.register Facility do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :price
   end
   f.actions
  end

  index do |c|
  	c.column :name
  	c.column :price
  end
end
