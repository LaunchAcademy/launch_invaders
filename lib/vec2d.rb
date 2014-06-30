class Vec2D
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def add(other)
    Vec2D.new(x + other.x, y + other.y)
  end

  def sub(other)
    Vec2D.new(x - other.x, y - other.y)
  end

  def normalize
    Vec2D.new(x / length, y / length)
  end

  def length_squared
    (x * x) + (y * y)
  end

  def length
    Math.sqrt(length_squared)
  end

  def scale(factor)
    Vec2D.new(x * factor, y * factor)
  end

end
