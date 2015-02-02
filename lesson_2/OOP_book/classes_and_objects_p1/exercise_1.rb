class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
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

end

zcar = MyCar.new("2015", "blue", "vtec")
zcar.spray_paint("red")