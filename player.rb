require_relative 'laser'
require_relative 'vec2d'
require_relative 'rect'

class Player
  def initialize(width, height)
    starting_x = (width - size.x) / 2
    starting_y = 9 * height / 10

    @pos = Vec2D.new(starting_x, starting_y)
    @accel_left = 0
    @accel_right = 0
  end

  def size
    Vec2D.new(20, 20)
  end

  def vel
    Vec2D.new(@accel_left + @accel_right, 0)
  end

  def bounds
    Rect.new(@pos, size)
  end

  def move
    @pos = @pos.add(vel)
  end

  def accelerate(direction)
    case direction
    when :left
      @accel_left = -1
    when :right
      @accel_right = 1
    end
  end

  def decelerate(direction)
    case direction
    when :left
      @accel_left = 0
    when :right
      @accel_right = 0
    end
  end

  def fire_laser
    Laser.new(@pos)
  end
end
