class User < ApplicationRecord
  def self.sign_in_from_omniauth(auth)
    find_by(provider:
    auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create(
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['first_name'],
      oauth_token: auth['credentials']['token'],
      email: auth['info']['email']
    )
  end

  def foursquare
    @foursquare ||= Foursquare2::Client.new(oauth_token: oauth_token,
                                            api_version: '20170215')
  end
end
