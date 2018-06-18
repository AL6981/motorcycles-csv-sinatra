require 'sinatra'
require 'pry'
require 'csv'
require_relative 'app/motorcycle.rb'

set :bind,'0.0.0.0'  # bind to all interfaces,http://www.sinatrarb.com/configuration.html

def array_of_motorcycle_objects
  motorcycles = []
  CSV.foreach('motorcycles.csv', headers: true) do |row|
    motorcycles << Motorcycle.new(row["id"], row["year"], row["make"], row["model"], row["description"], row["cc"], row["url"], row["image"])
  end
  motorcycles
end

get '/' do
  redirect to "/motorcycles"
  # user experiences more clarity
end

get '/motorcycles' do
  @motorcycles = array_of_motorcycle_objects
  erb :index
end

get '/motorcycle/:id' do
  @motorcycle = array_of_motorcycle_objects.find { |r| r.id == params[:id]}
  erb :show
end

get "/motorcycles/new" do
  erb :new
end

post '/motorcycles' do
  CSV.open("motorcycles.csv", "a") do |csv|
    csv << [array_of_motorcycle_objects.length + 1, params[:year],params[:make], params[:model],"#{params[:description]}",params[:cc],params[:url],params[:image]]
  end
  redirect to "/"
end
