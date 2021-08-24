require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
   erb :index
  end

  get '/about' do
    erb :about
  end

  run! if app_file == $0
end