require 'pg'

class Space

  attr_reader :id, :name, :description, :price

  def initialize(id, name, description, price)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.all
    connect_db
    @connection.exec('SELECT * FROM spaces').map do |space| 
      Space.new(space['id'], space['name'], space['description'], space['price'])
    end
  end

  def self.filter(start_date, end_date)
    return nil if start_date == nil || end_date == nil
    connect_db
    booked = @connection.exec("SELECT * FROM requests WHERE approval_status=true AND start_date BETWEEN' \ 
    ''#{start_date}' AND '#{end_date}' OR approval_status=true AND end_date BETWEEN '#{start_date}' AND '#{end_date}'")
    booked_array = booked.map do |space| space['space_id'] end
    all.delete_if { |space| booked_array.include?(space.id) }
  end

  def self.create(name, description, price)
    connect_db
    result = @connection.exec_params('INSERT INTO spaces (name, description, price)' \
    'VALUES ($1, $2, $3) RETURNING id;', [name, description, price])
    Space.new(result[0]['id'], name, description, price)
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
