require_relative 'invader'

class ElusiveInvader < Invader

  def update(world)
    lasers = world.lasers.map { |laser| laser.center }
    center = Vec2D.new(pos.x + size.x / 2.0, pos.y + size.y / 2.0)

    directions = lasers.map { |laser| center.sub(laser) }

    forces = directions.map do |direction|
      direction.normalize.scale(1.0 / direction.length_squared)
    end

    x_force = forces.reduce(0) { |total, force| total + force.x }
    x_force *= 5000.0

    vel = Vec2D.new(x_force, 1.0)

    @pos = pos.add(vel)
  end

  def color
    Gosu::Color::YELLOW
  end

end
