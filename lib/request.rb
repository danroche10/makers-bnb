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
    @con.exec("SELECT * FROM requests WHERE user_id = $1", [user_id]).map do |request|
      Request.new(id: request['id'], start_date: request['start_date'], end_date: request['end_date'],
      user_id: request['user_id'], space_id: request['space_id'], approval_status: request['approval_status'])
    end
  end
  
  def self.all_joined
    connect_db
    result = @con.exec("SELECT requests.id, requests.start_date, requests.end_date, requests.user_id AS guest_id, requests.space_id, requests.approval_status,users.email, spaces.name, spaces.user_id AS host_id, spaces.description, spaces.price 
    FROM requests
    INNER JOIN users ON requests.user_id=users.id
    INNER JOIN spaces ON requests.space_id=spaces.id;")
    test = result.map do |request|
      {"id": request['id'], "start_date": request['start_date'], "end_date": request['end_date'], "guest_user_id": request["guest_id"],
      "space_id": request['space_id'], "approval_status": request['approval_status'], "email": request['email'], "space_name": request["name"],
      "host_user_id": request["host_id"], "description": request["description"], "price": request["price"]}
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

Request.all_joined