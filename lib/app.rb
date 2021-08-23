require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
    'Hello!'
  end

  run! if app_file == $0
end