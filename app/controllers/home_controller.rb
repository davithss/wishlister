class HomeController < ApplicationController
  # before_action :set_auth

  def index
  end

  # def set_auth
  #   @auth = session[:omniauth] if session[:omniauth]
  # end

  def checkins
    @profile = current_user.foursquare.user("self")
    @user_photo = "#{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
    @checkins = current_user.foursquare.recent_checkins(limit:'10')
  end

  def wishlist
    @profile = current_user.foursquare.user("self")
    @user_photo = "#{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
  end

  def add_list_item
    current_user.foursquare.add_list_item(params[:item], venueId: params[:venue])
    redirect_to '/wishlist'
  end

  def delete_list_item
    binding.pry
    current_user.foursquare.delete_list_item(params[:listId], params[:venueId])
    redirect_to '/wishlist'
  end

  def list_info
    @profile = current_user.foursquare.user("self")
    @user_photo = "#{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
    @info = current_user.foursquare.list(params[:item], limit:'10')
  end
end
