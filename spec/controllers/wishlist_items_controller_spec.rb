require 'rails_helper'

RSpec.describe WishlistItemsController, type: :controller do
  let(:current_user) { create(:user) }

  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:foursquare]
    stub_request(:get, "https://api.foursquare.com/v2/users/self?oauth_token=LTKENYAWPD2F0CTEGG2NCQOFJJLHQDAJ4TFFZCOVMNRZB0NU&v=20170215").
    to_return(status: 200, body: File.read('spec/support/api_responses/foursquare/user/success.json') , headers: {"Content-Type"=> "application/json"})
    session[:user_id] = current_user.id
  end

  describe 'GET #create' do
    let(:wishlist) { create(:wishlist) }
    let(:wishlist_item_attributes) do
      attributes_for(:wishlist_item, wishlist_id: wishlist.id)
    end

    context 'with valid attributes' do
      it 'creates a new item in the list' do
        expect do
          post :create, params: { wishlist_item: wishlist_item_attributes }
        end.to change(WishlistItem, :count).by(1)
      end

      it 'redirects to wishlist#show' do
        post :create, params: { wishlist_item: wishlist_item_attributes }
        expect(response).to redirect_to(wishlists_path)
      end
    end

    context 'with invalid attributes' do
      let(:wishlist_item_attributes) { attributes_for(:wishlist_item, name: nil) }

      it 'does not save in the database' do
        expect do
          post :create, params: { wishlist_item: wishlist_item_attributes }
        end.not_to change(WishlistItem, :count)
      end

      it 'renders to recent_checkins' do
        post :create, params: { wishlist_item: wishlist_item_attributes }
        expect(response).to redirect_to(checkins_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:wishlist_item) { create(:wishlist_item) }

    it 'delete a item from the list' do
      delete :destroy, params: { id: wishlist_item.id }
      expect(response).to redirect_to(wishlists_path)
    end
  end
end
