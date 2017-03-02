require 'rails_helper'

RSpec.describe 'Home', type: :request do

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
