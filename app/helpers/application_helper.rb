module ApplicationHelper
	def yesno(x)
    x ? "Unlimited" : "Limited"
  end

  def currency_format(nominal, unit = "Rp.", format="%u %n")
    number_to_currency(nominal, unit: unit, format: format, precision: 0)
  end

  def display_error_messages!(res = nil, res_name = nil)
    res ||= resource
    res_name ||= defined?(resource_name) ? resource_name : res.class
    return "" if res.errors.empty?

    uniq_errors = res.errors.full_messages.uniq
    messages = uniq_errors.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => uniq_errors.count,
                      :resource => res_name)

    html = <<-HTML
      <b>Sorry, you have #{uniq_errors.count} error(s) in request:</b>
      <ul>#{messages}</ul>
      HTML
    html.html_safe
  end

  def status_class(status)
    return "label-warning" if status == Order::Status::PENDING
    return "label-success" if status == Order::Status::APPROVED
    "label-important"
  end

  def meridian_time(time)
    time = Time.now if time.blank?
    time = Time.at(time) if time.is_a?(Fixnum)
    time.strftime("%l:%M%P").gsub(/\s/,"")
  end
  
end
