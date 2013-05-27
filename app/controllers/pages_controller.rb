class PagesController < ApplicationController

  def home
  	@rooms = Room.all
  end

  def about
  	@rooms = Room.all
  end
end
