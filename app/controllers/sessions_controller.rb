class SessionsController < ApplicationController
  skip_before_action :verify_current_user, only: :create

  def create
    auth = request.env['omniauth.auth']
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to wishlists_path, notice: 'Signed in'
  end

  def destroy
    session[:user_id]  = nil
    session[:omniauth] = nil
    redirect_to root_url, notice: 'Signed out'
  end
end
