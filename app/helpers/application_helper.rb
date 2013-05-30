module ApplicationHelper
	def yesno(x)
    x ? "Unlimited" : "Limited"
  end

  def currency_format(nominal, unit = "Rp.", format="%u %n")
    number_to_currency(nominal, unit: unit, format: format, precision: 0)
  end
  
end
