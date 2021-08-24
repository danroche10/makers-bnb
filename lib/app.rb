require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'space'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
    'Hello!'
  end

  get '/makersbnb/spaces' do
    @space_list = Space.all
    erb(:'makersbnb/spaces')
  end

  get '/makersbnb/spaces/new' do
    erb(:'makersbnb/spaces/new')
  end

  post '/makersbnb/spaces/new' do
    Space.create(params[:name], params[:description], params[:price])
    redirect '/makersbnb/spaces'
  end

  run! if app_file == $0
end