OmniAuth.config.test_mode = true
omniauth_hash = {
  'provider' => 'foursquare',
  'uid' => '12345',
  'info' => {
    'name' => 'Chevchenko',
    'email' => 'hi@chev.com',
  },
  'credentials' => {
    'token' => 'LTKENYAWPD2F0CTEGG2NCQOFJJLHQDAJ4TFFZCOVMNRZB0NU',
    'secret' => 'hahaeuh23828',
  }
}
OmniAuth.config.add_mock(:foursquare, omniauth_hash)
