require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'space'
require './lib/user'
require './lib/request'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/makersbnb' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    if @user
      redirect '/makersbnb/spaces'
    end
    erb :index
  end
  
  post '/makersbnb' do
    if params[:password] == params[:password_confirmation]
      new_user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = new_user.id
      redirect '/makersbnb/spaces'
    else
      redirect '/makersbnb'
    end
  end

  get '/makersbnb/spaces' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    @space_list = Space.all
    erb(:'makersbnb/spaces')
  end

  get '/makersbnb/spaces/new' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    erb(:'makersbnb/spaces/new')
  end

  post '/makersbnb/spaces/new' do
    Space.create(params[:name], params[:description], params[:price])
    redirect '/makersbnb/spaces'
  end

  get '/makersbnb/spaces/:id' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    @space = Space.find(params[:id])
    erb(:'makersbnb/spaces/id')
  end

  post '/makersbnb/spaces/:id' do
    Space.book(params[:id])
    redirect '/makersbnb/spaces'
  end

  get '/makersbnb/about' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    erb :'makersbnb/about'
  end

  get '/makersbnb/login' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    if @user
      redirect '/makersbnb/spaces'
    end
    erb :'makersbnb/sessions/new'
  end

  post '/makersbnb/login' do
    authenticated_user = User.authenticate(email: params[:email], password: params[:password])
    if authenticated_user
      session[:user_id] = authenticated_user.id
      redirect('/makersbnb/spaces')
    else
      redirect('/makersbnb/login')
    end 
  end

  post '/makersbnb/sessions/destroy' do
    session.clear
    redirect('/makersbnb')
  end

  get '/makersbnb/requests' do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    user_id = @user.id
    @requests = Request.all(user_id)
    erb :'makersbnb/requests'
  end
  
  run! if app_file == $0
end