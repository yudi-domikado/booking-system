ActiveAdmin.register Room do

  controller do
    def show
      redirect_to edit_admin_room_path(params[:id])
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description, as: :text, input_html: {rows: 5}
      f.input :price
      f.input :picture, hint: image_tag(room.picture.url(:medium), style: "height: 50px;")
    end
    f.actions
  end

  index do
    column :picture do |room|
      image_tag room.picture.url(:medium)
    end

    column :name do |room|
      Sanitize.clean room.name
    end

    column :description do |room|
      Sanitize.clean room.description
    end

    column :actions do |room|
      content_tag :span do
        link_to("Edit", edit_admin_room_path(room)).
        concat(" | ").
        concat( link_to("Delete", admin_room_path(room), method: :delete, confirm: "You want to delete #{room.name}, are you sure?") )
      end
    end
  end

end
