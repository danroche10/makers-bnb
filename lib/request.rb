require 'pg'

class Request

  attr_reader :id, :start_date, :end_date, :user_id, :space_id, :approval_status

  def initialize(id:, start_date:, end_date:, user_id:, space_id:, approval_status:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @user_id = user_id
    @space_id = space_id
    @approval_status = approval_status
  end

  def self.create(start_date:, end_date:, user_id:, space_id:, approval_status:)
    connect_db
      result = @con.exec(
        "INSERT INTO requests (start_date, end_date, user_id, space_id, approval_status) VALUES ($1, $2, $3, $4, $5) RETURNING id, start_date, end_date, user_id, space_id, approval_status;", [start_date, end_date, user_id, space_id, approval_status])
      Request.new(id: result[0]['id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], user_id: result[0]['user_id'], space_id: result[0]['space_id'], approval_status: result[0]['approval_status'])    
  end

  def self.all(user_id)
    connect_db
    # add WHERE constraint
    @con.exec('SELECT * FROM requests').map do |request|
      Request.new(id: request['id'], start_date: request['start_date'], end_date: request['end_date'],
      user_id: request['user_id'], space_id: request['space_id'], approval_status: request['approval_status'])
    end
  end

  def self.connect_db
    if ENV['ENVIRONMENT'] == 'test'
      @con = PG.connect(dbname: 'makers_bnb_test')
    else
      @con = PG.connect(dbname: 'makers_bnb')
    end
  end
end