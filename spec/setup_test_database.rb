require 'pg'

def setup_test_database
  con = PG.connect :dbname => 'makers_bnb_test'
  con.exec 'TRUNCATE TABLE users, spaces, requests RESTART IDENTITY'
end