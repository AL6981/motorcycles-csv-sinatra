require 'sinatra'
require 'pry'
require 'csv'

set :bind,'0.0.0.0'  # bind to all interfaces,http://www.sinatrarb.com/configuration.html

get '/' do
  redirect to "/restaurants"
end

get '/restaurants' do
  @restaurants = CSV.readlines('restaurants.csv',headers: true)
  erb :index
end

get '/restaurant/:id' do
  erb :show
end
