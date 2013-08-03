colors = {"sap" => "#b70039", "stp" => "#0767a5", "domikado" => "#b8c223"}
%w(domikado sap stp).each do |company_name|
  company = Company.find_or_initialize_by_title(company_name.upcase)
  if company.new_record?
  	company.logo = File.new("#{Rails.root}/app/assets/images/#{company_name}.png")
  	company.color = colors[company_name]
  	company.save
  end
end

sap = Company.find_by_title("SAP")

%w(super_admin room_admin food_admin customer).each do |role_name|
	role = Role.find_or_initialize_by_name(role_name)
	role.save if role.new_record?
	email = role_name.gsub(/\_/,".")+"@example.com"
	user = User.find_or_initialize_by_email(email)
	if user.new_record?
		user.password = "password123"
		user.password_confirmation = user.password
		user.name = role_name.titleize
		user.role_id = role.id
		user.company_id = sap.id
		user.save
	end
end

%w(andromeda milkyway pinwheel thinkubator).each do |room_name|
	room = Room.find_or_initialize_by_name(room_name.titleize)
	if room.new_record?
  	room.picture = File.new("#{Rails.root}/app/assets/images/#{room_name}.jpg")
	  room.save
	end
end