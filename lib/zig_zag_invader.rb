
require_relative 'invader'

class ZigZagInvader < Invader

  OSCILLATE_PERIOD = 30

  attr_reader :pos, :vel, :accel

  def initialize(x, y)
    @accel = Vec2D.new(0.5, 0.01)
    @vel = Vec2D.new(0, 0.5)
    @ticks = OSCILLATE_PERIOD / 2.0

    super(x, y)
  end

  def update(world)
    @vel = vel.add(accel)
    @pos = pos.add(vel)

    @ticks += 1

    if @ticks > OSCILLATE_PERIOD
      @accel = Vec2D.new(-accel.x, accel.y)
      @ticks = 0
    end
  end

end
