class World
  attr_reader :width, :height
  attr_reader :invaders, :player, :lasers
  attr_reader :invaders_remaining, :spawn_delay

  def initialize(width, height, invader_count)
    @width = width
    @height = height

    @invaders_remaining = invader_count
    @spawn_delay = 0
    @invaders = []

    @player = Player.new(width, height)
    @lasers = []
  end

  def update
    spawn_invaders()

    invaders.each do |invader|
      invader.update(self)
    end

    lasers.each do |laser|
      laser.update(self)
    end

    player.update(self)

    invaders.each do |invader|
      lasers.each do |laser|
        if !laser.destroyed? && laser.bounds.overlaps?(invader.bounds)
          laser.destroy!
          invader.destroy!
          break
        end
      end
    end

    lasers.reject! { |laser| laser.destroyed? }
    invaders.reject! { |invader| invader.destroyed? }
  end

  def start_moving_player(direction)
    player.start_moving(direction)
  end

  def stop_moving_player(direction)
    player.stop_moving(direction)
  end

  def player_fire_laser
    lasers << player.fire_laser
  end

  def spawn_invaders
    if invaders_remaining > 0
      if spawn_delay <= 0
        invader_type = [SimpleInvader, AcceleratingInvader].sample
        invaders << invader_type.new(width)
        @spawn_delay = rand(100)
        @invaders_remaining -= 1
      else
        @spawn_delay -= 1
      end
    end
  end

end
