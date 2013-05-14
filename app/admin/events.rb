ActiveAdmin.register Event do
   form do |c|
    c.inputs "Details" do
    c.input :starts_at
    c.input :ends_at
    c.input :title
    c.input :description
	end
	c.actions
    end

    index do |f|
    f.column :title
    f.column :description
    f.column :starts_at
    f.column :ends_at
    f.column :email do |x|
    	x.user.email
    end
	end


	# index do |c|
 #    c.column :name
 #      c.column :picture do |food|
 #   	    image_tag food.picture.url(:thumb)
 #      end
 #      c.column :price do |food|
 #        number_to_currency(food.price, unit: "Rp.", format: "%u %n")
 #      end
 #    c.column :quantity
 #      c.column :unlimited do |food|
 #    	food.unlimited ? "Unlimited" : "Limited"
 #      end
 #      c.column :category do |cat|
 #        cat.category.category # seharusnya namanya name biar ga bingung
 #      end
 #    c.column :tag_list 
 #      actions
 #    end
end
