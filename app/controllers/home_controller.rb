class HomeController < ApplicationController

  def index
  end

  def checkins
    @profile = current_user.foursquare.user("self")
    @user_photo = "#{@profile['photo']['prefix']}40x40#{@profile['photo']['suffix']}"
    @checkins = current_user.foursquare.recent_checkins(limit:'10')
  end

end
