class HomeController < ApplicationController
  def show
    @rooms = Room.all
    @companies = Company.all
    @cart = Cart.find_or_create_by_session_id(session_cart)
  end
end