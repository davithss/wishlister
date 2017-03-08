require 'rails_helper'

RSpec.describe WishlistsController, type: :controller do
  let(:current_user) { create(:user) }
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:foursquare]
    stub_request(:get, 'https://api.foursquare.com/v2/users/self?oauth_token=LTKENYAWPD2F0CTEGG2NCQOFJJLHQDAJ4TFFZCOVMNRZB0NU&v=20170215')
      .to_return(status: 200, body: File.read('spec/support/api_responses/foursquare/user/success.json'), headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, 'https://api.foursquare.com/v2/checkins/recent?oauth_token=LTKENYAWPD2F0CTEGG2NCQOFJJLHQDAJ4TFFZCOVMNRZB0NU&limit=10&v=20170215')
      .to_return(status: 200, body: File.read('spec/support/api_responses/foursquare/recent_checkins/checkins.json'), headers: { 'Content-Type' => 'application/json' })
    session[:user_id] = current_user.id
  end

  describe 'GET #index' do
    let(:wishlist) { create(:wishlist) }
    before do
      get :index
    end
    it 'returns all lists' do
      expect(assigns(:wishlists).count).to eq Wishlist.count
    end

    it 'redirects to index template' do
      expect(response).to  render_template :index
    end
  end

  describe 'GET #show' do
    let(:wishlist) { create(:wishlist) }
    before do
      get :show, params: { id: wishlist.id }
    end

    it 'returns specified list' do
      expect(assigns(:wishlist)).to eq wishlist
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'is assigns new list' do
      expect(assigns(:wishlist)).to be_a_new(Wishlist)
    end

    it 'render :new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #create' do
    context 'with valid attributes' do
      let(:wishlist) { create(:wishlist) }
      let(:wishlist_attributes) { attributes_for(:wishlist) }

      it 'saves new list in the database' do
        expect do
          post :create, params: { wishlist: wishlist_attributes }
        end.to change(Wishlist, :count).by(1)
      end

      it 'redirects to wishlist#show' do
        post :create, params: { wishlist: wishlist_attributes }
        expect(response).to redirect_to wishlist_path(assigns(:wishlist))
      end
    end

    context 'with invalid attributes' do
      let(:wishlist_attributes) do
        attributes_for(:wishlist, name: nil)
      end

      it 'does not save the new list in database' do
        expect do
          post :create, params: { wishlist: wishlist_attributes }
        end.not_to change(Wishlist, :count)
      end

      it 'renders :new template' do
        post :create, params: { wishlist: wishlist_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    let(:wishlist) { create(:wishlist) }
    before do
      get :edit, params: { id: wishlist.id }
    end

    it 'assigns requested list to @wishlist' do
      expect(assigns(:wishlist)).to eq wishlist
    end

    it 'renders :edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:wishlist) { create(:wishlist) }

    context 'with valid attributes' do
      it 'redirects to index' do
        patch :update,
              params: { id: wishlist.id, wishlist: { name: 'black ice' } }
        expect(response).to redirect_to(wishlist_path(wishlist))
      end
    end

    context 'with invalid attributes' do
      it 'render :edit template' do
        patch :update,
              params: { id: wishlist.id, wishlist: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:wishlist) { create(:wishlist) }

    it 'delete the list' do
      delete :destroy, params: { id: wishlist.id }
      expect(response).to redirect_to(wishlists_path)
    end
  end

  describe 'GET #checkins' do
    it 'recent checkings from friends' do
      client = stub_request(:get, 'https://api.foursquare.com/v2/checkins/recent?oauth_token=current_user.oauth_token&v=20170215')
               .to_return(body: File.read('spec/support/api_responses/foursquare/recent_checkins/checkins.json'))
      response = JSON.parse(client.response.body)
      expect(response['response']['recent'][0]['user']['firstName']).to eq('Pardal')
    end
  end
end
