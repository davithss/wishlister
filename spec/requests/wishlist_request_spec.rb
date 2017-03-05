require 'rails_helper'

RSpec.describe 'Wishlists', type: :request do
  # let!(:current_user) { create(:user) }

  # before do
  #   login_as(current_user, scope: :current_user)
  # end

  describe 'GET #index' do
    before(:all) do
      current_user =  create(:user)
      wishlist = create(:wishlist)
      login_as(current_user, scope: :current_user)
      get wishlists_path
    end
    it 'returns all lists' do
      expect(assigns(:wishlists).count).to eq Wishlist.count
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:wishlist) { create(:wishlist) }
    before do
      get wishlist_path(wishlist)
    end

    it 'returns specified list' do
      expect(assigns(:wishlist)).to eq wishlist
    end
  end

  describe 'GET #new' do
    before do
      get new_wishlist_path
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
          post wishlists_path, params: { wishlist: wishlist_attributes }
        end.to change(Wishlist, :count).by(1)
      end

      it 'redirects to wishlist#show' do
        post wishlists_path, params: { wishlist: wishlist_attributes }
        expect(response).to redirect_to wishlist_path(assigns(:wishlist))
      end
    end

    context 'with invalid attributes' do
      let(:wishlist_attributes) do
        attributes_for(:wishlist, name: nil)
      end

      it 'does not save the new list in database' do
        expect do
          post wishlists_path, params: { wishlist: wishlist_attributes }
        end.not_to change(Wishlist, :count)
      end

      it 'renders :new template' do
        post wishlists_path, params: { wishlist: wishlist_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    let(:wishlist) { create(:wishlist) }
    before do
      get edit_wishlist_path(wishlist)
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
        patch wishlist_path(wishlist),
        params: { wishlist: { name: 'black ice' } }
        expect(response).to redirect_to(wishlist_path(wishlist))
      end
    end

    context 'with invalid attributes' do
      it 'render :edit template' do
        patch wishlist_path(wishlist),
        params: { wishlist: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:wishlist) { create(:wishlist) }

    it 'delete the list' do
      delete wishlist_path(wishlist)
      expect(response).to redirect_to(wishlists_path)
    end
  end

  describe 'GET #checkins' do
    let(:user) { create(:user) }

    it 'recent checkings from friends' do
      client = stub_request(:get, "https://api.foursquare.com/v2/checkins/recent?oauth_token=user.oauth_token&v=20170215").
      to_return(body: File.read('spec/support/api_responses/foursquare/recent_checkins/checkins.json'))
      response = JSON.parse(client.response.body)
      expect(response['response']['recent'][0]['user']['firstName']).to eq('Pardal')
    end
  end

end
