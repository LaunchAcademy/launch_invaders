class Player
  attr_reader :moving, :pos, :top_speed

  def initialize(width, height)
    starting_x = (width - size.x) / 2.0
    starting_y = 9.0 * height / 10.0

    @pos = Vec2D.new(starting_x, starting_y)
    @moving = { left: 0.0, right: 0.0 }
    @top_speed = width / 100.0
  end

  def size
    Vec2D.new(20.0, 20.0)
  end

  def vel
    Vec2D.new(moving[:left] + moving[:right], 0)
  end

  def bounds
    Rect.new(pos, size)
  end

  def move
    @pos = pos.add(vel)
  end

  def start_moving(direction)
    case direction
    when :left
      moving[:left] = -top_speed
    when :right
      moving[:right] = top_speed
    end
  end

  def stop_moving(direction)
    moving[direction] = 0
  end

  def fire_laser
    Laser.new(Vec2D.new(pos.x + (size.x - Laser::SIZE.x) / 2.0, pos.y))
   end
end
