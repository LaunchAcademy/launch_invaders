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
    if invaders_remaining > 0
      if spawn_delay <= 0
        invader_type = [Invader].sample
        invaders << invader_type.new(width)
        @spawn_delay = rand(100)
        @invaders_remaining -= 1
      else
        @spawn_delay -= 1
      end
    end

    invaders.each do |invader|
      invader.move
    end

    lasers.each do |laser|
      laser.move
    end

    player.move

    lasers.each do |laser|
      invaders.each do |invader|
        if laser.bounds.overlaps?(invader.bounds)
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
end
