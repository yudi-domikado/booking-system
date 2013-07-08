ActiveAdmin.register Company do
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :logo, hint: image_tag(company.logo.url(:thumb), style: "height: 50px;")
    end
    f.actions
  end
end
