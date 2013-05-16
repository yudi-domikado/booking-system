class UsersController < ApplicationController
before_filter :authenticate_user! # harus login
def index
end

def checkout
@cart = Cart.find_or_create_by_session_id(session_cart)	
end

def show
redirect_to rooms_path
end

end