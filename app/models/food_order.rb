class FoodOrder < Order
	 extend FriendlyId
  friendly_id :code, use: :slugged
end