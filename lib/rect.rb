class Rect
  def initialize(origin, size)
    @origin = origin
    @size = size
  end

  def top
    @origin.y
  end

  def bottom
    @origin.y + @size.y
  end

  def left
    @origin.x
  end

  def right
    @origin.x + @size.x
  end

  def overlaps?(other)
    top < other.bottom && bottom > other.top &&
      right > other.left && left < other.right
  end
end
