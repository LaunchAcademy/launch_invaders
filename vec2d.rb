class Vec2D
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def add(other)
    Vec2D.new(x + other.x, y + other.y)
  end
end
