require_relative 'invader'

class SpeedyInvader < Invader
  attr_reader :pos, :vel, :accel

  def initialize(x, y)
    @accel = Vec2D.new(0, 0.01)
    @vel = Vec2D.new(0, 0.5)

    super(x, y)
  end

  def update(world)
    @vel = vel.add(accel)
    @pos = pos.add(vel)
  end
end
