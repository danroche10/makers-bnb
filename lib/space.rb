require 'pg'

class Space

  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id, name, description, price, user_id)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.all
    connect_db
    @connection.exec('SELECT * FROM spaces').map do |space| 
      Space.new(space['id'], space['name'], space['description'], space['price'], space['user_id'])
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

  def self.create(name, description, price, user_id)
    connect_db
    result = @connection.exec_params('INSERT INTO spaces (name, description, price, user_id)' \
    'VALUES ($1, $2, $3, $4) RETURNING id;', [name, description, price, user_id])
    Space.new(result[0]['id'], name, description, price, user_id)
  end

  def self.find(id)
    connect_db
    result = @connection.exec("SELECT * FROM spaces WHERE id = $1", [id])
    Space.new(result[0]['id'], result[0]['name'], result[0]['description'], result[0]['price'], result[0]['user_id'])
  end

  def self.connect_db
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makers_bnb_test')
    else
      @connection = PG.connect(dbname: 'makers_bnb')
    end
  end
end
