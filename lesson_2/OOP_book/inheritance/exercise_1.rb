module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model
  @@car_num = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@car_num += 1
  end

  def self.number_of_vehicles
    puts "I have #{@@car_num} vehicles"
  end

  def self.mileage_calc(gallons, miles)
    miles/gallons
  end

  def speed_up(num)
    @current_speed += num
  end

  def brake(num)
    @current_speed -= num
  end

  def shut_off
    @current_speed = 0
  end

  def current_speed
    @current_speed
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} is cool"
  end

  def age_of_vehicle
    age_calc(@year.to_i)
  end

  private

    def age_calc(year)
      Time.now.year - year
    end
end

class MyCar < Vehicle

  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}"
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color}, #{self.year}, #{self.model}"
  end
end

mycar = MyTruck.new("1999", "blue", "lexus")
puts mycar
mytruck = MyCar.new("2012", "red", "camry")
puts mytruck
Vehicle.number_of_vehicles
puts mytruck.age_of_vehicle