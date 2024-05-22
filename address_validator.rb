require_relative 'lib/address_validator'
require_relative 'lib/address_validator_client'

auth_id = ENV['SMARTY_AUTH_ID']
auth_token = ENV['SMARTY_AUTH_TOKEN']
file_path = ARGV[0]

client = AddressValidatorClient.new(auth_id, auth_token)
validator = AddressValidator.new(client)

validator.validate(file_path)