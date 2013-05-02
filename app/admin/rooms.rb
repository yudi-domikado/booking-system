ActiveAdmin.register Room do
    form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :description
        f.input :price
        f.input :picture
      end
      f.actions
    end
end
