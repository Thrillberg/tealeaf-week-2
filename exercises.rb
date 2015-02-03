module Fast
  def is_fast?(speed)
    speed > 90 ? true : false
  end
end

class Vehicle
@@number_of_vehicles = 0
  def self.number_of_vehicles
    puts @@number_of_vehicles
  end
  def initialize
    @@number_of_vehicles += 1
  end
  def speed_up(number)
    speed += number
  end
  def brake(number)
    speed -= number
  end
  def shut_off
    speed = 0
  end 
 
end

class MyCar < Vehicle
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end
  include Fast
  attr_accessor :color
  attr_reader :year
  def spray_paint(color)
    self.color = color
  end
  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  def to_s
    "My car is a #{self.color}, #{self.year}, #{@model}!"
  end
  TYPE_OF_VEHICLE = "cool"
end

class MyTruck < Vehicle
  TYPE_OF_VEHICLE = "less cool"
end

carolla = MyCar.new(1990, 'red', 'carolla')
truckie = MyTruck.new
puts Vehicle.number_of_vehicles
puts carolla.is_fast?(100)
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors