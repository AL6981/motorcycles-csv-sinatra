require 'sinatra'
require 'pry'
require 'csv'
require_relative 'app/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces,http://www.sinatrarb.com/configuration.html

def restaurants
  @restaurants = []
  restaurant_data = CSV.readlines('restaurants.csv',headers: true)
  restaurant_data.each do |r|
    @restaurants << Restaurant.new(r["id"], r["name"], r["address"], r["description"], r["url"], r["image"])
  end
  @restaurants
end

get '/' do
  redirect to "/restaurants"
end

get '/restaurants' do
  @restaurants = restaurants
  erb :index
end

get '/restaurant/:id' do
  @restaurant = restaurants[params[:id].to_i]
  erb :show
end
