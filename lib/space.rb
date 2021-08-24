require 'pg'

class Space

  attr_reader :id, :name, :description, :price, :booked

  def initialize(id, name, description, price, booked = false)
    @id = id
    @name = name
    @description = description
    @price = price
    @booked = booked
  end

  def self.all
    connect_db
    @connection.exec('SELECT * FROM spaces').map do |space| 
      Space.new(space['id'], space['name'], space['description'], space['price'], space['booked'])
    end
  end

  def self.create(name, description, price)
    connect_db
    result = @connection.exec_params('INSERT INTO spaces (name, description, price)' \
    'VALUES ($1, $2, $3) RETURNING id;', [name, description, price])
    Space.new(result[0]['id'], name, description, price)
  end

  def self.booked?(id)
    connect_db
    result = @connection.exec("SELECT * FROM spaces WHERE id = #{id}")
    result[0]['booked']
  end

  def self.book(id)
    connect_db
    result = @connection.exec("UPDATE spaces SET booked = TRUE WHERE id = #{id}")
  end

  def self.connect_db
    if ENV['ENVIRONMENT'] = 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end