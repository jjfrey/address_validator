# address_validator

Setup:
using terminal, run the following commands to user your own API credentials

`export SMARTY_AUTH_ID=foo`

`export SMARTY_AUTH_TOKEN=bar`

How to run:
`ruby address_validator.rb file_name`

Running tests:
`rspec spec`

**Design considerations**
My design focused mostly around 3 things:
1. The data model `Address` simulate a rails activerecord model and allow for easier testing as the application becomes more complex. Also to allow for different models to possibly use the validator in the future.
2. `AddressValidatorClient` created in order to isolate the external API call for tests.
3. `AddressValidator` that uses the previous classes together in order to execute the validation on the address.   