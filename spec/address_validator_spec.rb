require 'spec_helper'

RSpec.describe AddressValidator do
  let(:api_client) { instance_double('AddressValidatorClient') }
  let(:validator) { AddressValidator.new(api_client) }

  before do
    allow(api_client).to receive(:validate_address).with('143 e Maine Street', 'Columbus', '43215')
      .and_return({'delivery_line_1' => '143 E Main St', 'last_line' => 'Columbus, OH 43215-5370'})
    allow(api_client).to receive(:validate_address).with('1 Empora St', 'Title', '11111')
      .and_return(nil)
  end

  it 'validates addresses from a CSV file' do
    csv_row1 = "Street,City,Zip Code\n143 e Maine Street,Columbus,43215\n"
    csv_row2 = "Street,City,Zip Code\n1 Empora St,Title,11111\n"
    allow(CSV).to receive(:foreach).and_yield(CSV.parse_line(csv_row1, headers: true))
                                .and_yield(CSV.parse_line(csv_row2, headers: true))

    expect { validator.validate('dummy_path') }.to output(
      "143 e Maine Street, Columbus, 43215 -> 143 E Main St, Columbus, OH 43215-5370\n" +
      "1 Empora St, Title, 11111 -> Invalid Address\n"
    ).to_stdout
  end
end
