require 'sinatra'
require 'pry'
require 'csv'
require_relative 'app/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces,http://www.sinatrarb.com/configuration.html

def array_of_restaurant_objects
  restaurants = []
  CSV.foreach('restaurants.csv', headers: true) do |row|
    restaurants << Restaurant.new(row["id"], row["name"], row["address"], row["description"], row["url"], row["image"])
  end
  restaurants
end

get '/' do
  redirect to "/restaurants"
end

get '/restaurants' do
  @restaurants = array_of_restaurant_objects
  erb :index
end

get '/restaurant/:id' do
  @restaurant = array_of_restaurant_objects.find { |r| r.id == params[:id]}
  erb :show
end
