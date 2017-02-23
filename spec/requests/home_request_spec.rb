require 'rails_helper'
require 'Foursquare2'

RSpec.describe 'Home', type: :request do
  describe 'GET #index'
    it "expect sign in" do
      Foursquare2.configure do |config|
        config.client_id = 'awesome'
        config.client_secret = 'sauce'
        config.api_version = 5551234
        config.ssl = true
      end
      client = Foursquare2::Client.new
      client.client_id.should == 'awesome'
      client.client_secret.should == 'sauce'
      client.api_version.should == 5551234
      client.ssl.should == true
    end


  describe 'GET #checkins'

   context "Using foursquare API and bringing checkins" do
    it "expect receive recent checkins from friends" do
      expect do
        stub_get("https://api.foursquare.com/v2/checkins/recent?oauth_token=#{@client.oauth_token}&limit=2", "checkins/friend_checkins.json")
        checkins = client.recent_checkins(:limit => 2)
        checkins.count.should == 2
        checkins.first.venue.name.should == 'Buffalo Billiards'
        checkins.last.user.firstName.should == 'David'
      end
    end
  end

end
