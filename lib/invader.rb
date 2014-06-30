class Invader
  def initialize(x, y)
    @pos = Vec2D.new(x, y)
    @destroyed = false
  end

  def update(world)
    @pos = @pos.add(vel)
  end

  def self.size
    Vec2D.new(20, 20)
  end

  def bounds
    Rect.new(@pos, Invader.size)
  end

  def vel
    Vec2D.new(0, 1)
  end

  def destroy!
    @destroyed = true
  end

  def destroyed?
    @destroyed
  end
end
