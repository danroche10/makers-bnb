require 'pg'

class Request

  attr_reader :id, :start_date, :end_date, :user_id, :space_id, :approval_status

  def initialize(id:, start_date:, end_date:, user_id:, space_id:, approval_status = null)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @user_id = user_id
    @space_id = space_id
    @approval_status = approval_status
  end

  # def self.all(user_id)
  #   return nil unless id
  #   connect_db
  #   result = @con.exec("SELECT * FROM requests WHERE user_id = $1", [user_id]).map do |request|
  #     User.new(id: request[0]['id'], start_date: request[0]['start_date'], end_date: request[0]['end_date'], 
  #     user_id: request[0]['user_id'], request[0]['space_id'], request[0]['approval_status'])
  #   end
  # end

  def self.create(start_date:, end_date:, user_id:, space_id:)
    connect_db
      result = @con.exec(
        "INSERT INTO users (start_date, end_date, user_id, space_id) VALUES ($1, $2, $3, $4) RETURNING id, start_date, end_date, user_id, space_id;", [start_date, end_date, user_id, space_id])
      Request.new(id: result[0]['id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], user_id: result[0]['user_id'], space_id: result[0]['space_id'])    
  end



  def self.connect_db
    if ENV['ENVIRONMENT'] == 'test'
      @con = PG.connect(dbname: 'makers_bnb_test')
    else
      @con = PG.connect(dbname: 'makers_bnb')
    end
  end
end