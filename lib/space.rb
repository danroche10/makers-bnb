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

  def self.filter(start_date, end_date)
    #unbooked = all.select { |space| @connection.exec("SELECT * FROM requests WHERE space_id=#{space.id} AND approval_status=null OR approval_status=false") }
    booked_but_available = all.select { |space| @connection.exec("SELECT * FROM requests WHERE space_id=#{space.id} AND approval_status=true AND start_date NOT BETWEEN '#{start_date}' AND '#{end_date}' AND end_date NOT BETWEEN '#{start_date}' AND '#{end_date}'") }
    p booked_but_available.count
    #{start_date} < start_date < #{end_date})
    # get spaceid
    # check requests table with spaceid
    # compare start date/end date/approval status
    # select only ones that have requirements
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
    @connection.exec("UPDATE spaces SET booked = TRUE WHERE id = #{id}")
  end

  def self.find(id)
    connect_db
    result = @connection.exec("SELECT * FROM spaces WHERE id = $1", [id])
    Space.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'])
  end

  def self.connect_db
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end

p Space.filter("2022-03-10", "2022-04-10")