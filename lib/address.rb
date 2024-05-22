class Address
    attr_reader :street, :city, :zip_code
  
    def initialize(street, city, zip_code)
      @street = street
      @city = city
      @zip_code = zip_code
    end
  
    def formatted
      "#{@street}, #{@city}, #{@zip_code}"
    end
  end