require 'pg'

class Space

  attr_reader :name, :description, :price, :booked

  def initialize(name, description, price, booked)
    @name = name
    @description = description
    @price = price
    @booked = booked
  end

  def self.all

    if ENV['ENVIRONMENT'] = 'test'
      PG.connect(dbname: makers_bnb_test)
    else
      PG.connect(dbname: makers_bnb)

    #connect to DB
    #iterate through the test database rows through .map
    #create new space objects from each row
  end

end