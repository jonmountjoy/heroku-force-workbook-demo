require "sinatra/base"
require 'force'
require "omniauth"
require "omniauth-salesforce"

class MyApp < Sinatra::Base
  enable :sessions

  configure do
    set :session_secret, 'super secret'
  end

  use OmniAuth::Builder do
    provider :salesforce, ENV['SALESFORCE_KEY'], ENV['SALESFORCE_SECRET']
  end

  before /^(?!\/(auth.*))/ do   
    redirect '/authenticate' unless session[:instance_url]
  end


  helpers do
    def client
      @client ||= Force.new instance_url:  session['instance_url'], 
                            oauth_token:   session['token'],
                            refresh_token: session['refresh_token'],
                            client_id:     ENV['SALESFORCE_KEY'],
                            client_secret: ENV['SALESFORCE_SECRET']
    end
  end


  get '/' do
    accounts= client.query("select Id, Name from Account")    
    accounts.map(&:Name).join(',')
  end


  get '/authenticate' do
    redirect "/auth/salesforce"
  end


  get '/auth/salesforce/callback' do
    credentials = env["omniauth.auth"]["credentials"]
    session['token'] = credentials["token"]
    session['refresh_token'] = credentials["refresh_token"]
    session['instance_url'] = credentials["instance_url"]
    redirect '/'
  end

  get '/auth/failure' do
    params[:message]
  end

  get '/unauthenticate' do
    session.clear 
    'Goodbye - you are now logged out'
  end

  run! if app_file == $0

end
