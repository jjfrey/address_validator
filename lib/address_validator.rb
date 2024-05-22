require_relative 'address_validator_client'
require_relative 'address'
require 'csv'

class AddressValidator
  def initialize(address_validator_client)
    @address_validator_client = address_validator_client
  end

  def validate(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      address = Address.new(row['Street'], row['City'], row['Zip Code'])
      validated = @address_validator_client.validate_address(address.street, address.city, address.zip_code)
      if validated
        corrected_address = "#{validated['delivery_line_1']}, #{validated['last_line']}"
        puts "#{address.formatted} -> #{corrected_address}"
      else
        puts "#{address.formatted} -> Invalid Address"
      end
    end
  end
end
