require 'pg'

class User

  attr_reader :id, :email, :password

  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password = password
  end

  def self.create(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makers_bnb_test')
    else
      con = PG.connect(dbname: 'makers_bnb')
    end
    result = con.exec(
      "INSERT INTO users (email, password) VALUES ($1, $2) RETURNING id, email, password;", [email, password])
    User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.find(id)
    return nil unless id
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makers_bnb_test')
    else
      con = PG.connect(dbname: 'makers_bnb')
    end
    result = con.exec(
      "SELECT * FROM users WHERE id = $1", [id])
      User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password']) 
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'makers_bnb_test')
    else
      con = PG.connect(dbname: 'makers_bnb')
    end
    result = con.exec("SELECT * FROM users WHERE email = $1", [email])
    return unless result.any?

    return unless (result[0]['password']) == password

    User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['password']) 

  end
end