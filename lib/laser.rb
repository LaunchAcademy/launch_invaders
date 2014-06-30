require_relative 'vec2d'

class Laser
  SIZE = Vec2D.new(4.0, 8.0)

  def initialize(pos)
    @pos = pos
    @destroyed = false
  end

  def size
    SIZE
  end

  def bounds
    Rect.new(@pos, size)
  end

  def vel
    Vec2D.new(0, -5)
  end

  def update(world)
    @pos = @pos.add(vel)
  end

  def destroy!
    @destroyed = true
  end

  def destroyed?
    @destroyed
  end
end
