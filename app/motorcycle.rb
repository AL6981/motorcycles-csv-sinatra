class Motorcycle
  attr_reader :id, :year, :make, :model, :description, :cc, :url, :image

  def initialize(id, year, make, model, description, cc, url, image)
    @id = id
    @year = year
    @make = make 
    @model = model 
    @description = description
    @cc = cc
    @url = url
    @image = image 
  end
end
