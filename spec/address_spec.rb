require 'spec_helper'

RSpec.describe Address do
  let(:address) { Address.new('143 e Maine Street', 'Columbus', '43215') }

  it 'formats the address correctly' do
    expect(address.formatted).to eq('143 e Maine Street, Columbus, 43215')
  end
end
