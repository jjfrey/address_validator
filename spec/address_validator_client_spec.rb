require 'spec_helper'

RSpec.describe AddressValidatorClient do
  let(:auth_id) { 'test_id' }
  let(:auth_token) { 'test_token' }
  let(:client) { AddressValidatorClient.new(auth_id, auth_token) }

  it 'validates an address correctly' do
    stub_request(:get, "https://us-street.api.smartystreets.com/street-address/?auth-id=test_id&auth-token=test_token&city=Columbus&street=143%20e%20Maine%20Street&zipcode=43215").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
      })
      .to_return(body: '[{"delivery_line_1":"143 E Main St","last_line":"Columbus, OH 43215-5370"}]', status: 200)

    result = client.validate_address('143 e Maine Street', 'Columbus', '43215')
    expect(result['delivery_line_1']).to eq('143 E Main St')
  end

  it 'returns nil for invalid address' do
    stub_request(:get, "https://us-street.api.smartystreets.com/street-address/?auth-id=test_id&auth-token=test_token&city=Title&street=1%20Empora%20St&zipcode=11111").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Ruby'
           })
      .to_return(body: '[]', status: 200)

    result = client.validate_address('1 Empora St', 'Title', '11111')
    expect(result).to be_nil
  end
end
