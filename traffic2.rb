module TL
  Go = "#00FF30"
  Wait = "#FFFC00"
  Stop = "#FF0000"
end 

class TrafficLight  
  include Enumerable
  include TL

  # def each
  #   yield [true, false, false]
  #   yield [true, true, false]
  #   yield [false, false, true]
  #   yield [false, true, false]
  # end

  def each
    yield TL::Go
    yield TL::Wait
    yield TL::Stop
    yield TL::Wait
  end


end

class Bulb < Shoes::Shape
  attr_accessor :stack
  attr_accessor :left
  attr_accessor :top
  attr_accessor :switched_on
  
  include TL

  def initialize(stack, left, top, switched_on = false)    
    self.stack = stack
    self.left = left    
    self.top = top
    self.switched_on = switched_on
    draw left, top, bulb_colour
  end
  
  # HINT: Shouldn't need to change this method
  def draw(left, top, colour)    
    stack.app do
      fill colour
      stack.append do
        oval left, top, 50
      end
    end
  end
  
  def bulb_colour
    "#999999"
  end  
end



class GoBulb < Bulb
  def bulb_colour
    if self.switched_on == true
      TL::Go
    else
      "#999999"
    end
  end
end 

class WaitBulb < Bulb
  def bulb_colour
    if self.switched_on == true
      TL::Wait
    else
      "#999999"
    end
  end
end 

class StopBulb < Bulb
  def bulb_colour
    if self.switched_on == false
      TL::Stop
    else
      "#999999"
    end
  end
end


Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "000", :curve => 10, :margin => 25  
  stroke black    
  
  @traffic_light = TrafficLight.new
  @top = StopBulb.new self, 50, 40, false     
  @middle = WaitBulb.new self, 50, 100, false
  @bottom = GoBulb.new self, 50, 160, false

  @top.bulb_colour = "#FF0000"
  
  click do
  
  end
end