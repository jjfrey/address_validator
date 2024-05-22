require 'httparty'
require 'json'

class AddressValidatorClient
  include HTTParty
  base_uri 'https://us-street.api.smartystreets.com/street-address'

  def initialize(auth_id, auth_token)
    @auth_id = auth_id
    @auth_token = auth_token
  end

  def validate_address(street, city, zip_code)
    response = self.class.get("", query: {
      'auth-id' => @auth_id,
      'auth-token' => @auth_token,
      'street' => street,
      'city' => city,
      'zipcode' => zip_code
    })
    return nil if response.code != 200 || response.body.empty?
    JSON.parse(response.body).first
  end
end