require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'space'
require './lib/user'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/makersbnb' do
   erb :index
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

  get '/makersbnb/spaces/:id' do
    @space = Space.find(params[:id])
    erb(:'makersbnb/spaces/id')
  end

  post '/makersbnb/spaces/:id' do
    Space.book(params[:id])
    redirect '/makersbnb/spaces'
  end

  get '/about' do
    erb :about
  end

  post '/register' do
    User.create(email: params[:email], password: params[:password])
    redirect '/makersbnb/spaces'
  end

  get '/login' do
    erb :'makersbnb/sessions/new'
  end

  post '/login' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/makersbnb/spaces')
    else
      redirect('/login')
    end 
  end
  
  run! if app_file == $0
end