require 'rails_helper'

RSpec.describe 'Sessions', type: :request do

  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:foursquare]
  end

  describe 'GET #create' do

    it 'can sign in with foursquare account' do
      expect do
        get '/auth/:provider/callback', params: { provider: :foursquare }
      end.to change(User, :count).by(1)
    end

    it 'must create a session' do
      get '/auth/:provider/callback', params: { provider: :foursquare }
      expect(session[:user_id]).to_not be_nil
    end

    it 'redirects to wishlist' do
      get '/auth/:provider/callback', params: { provider: :foursquare }
      expect(response).to redirect_to wishlists_path
    end
  end

  describe 'DELETE #destroy' do
    before do
      get '/auth/:provider/callback', params: { provider: :foursquare }
    end

    it 'delete the session' do
      get '/signout'
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to sign in page' do
      get '/signout'
      expect(response).to redirect_to root_url
    end
  end

end
