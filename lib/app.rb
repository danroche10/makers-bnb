require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/user'

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

  post '/register' do
    User.create(email: params[:email], password: params[:password])
    redirect '/spaces'
  end

  get '/sessions/new' do
    erb :makersbnb/sessions/new
  end


  run! if app_file == $0
end