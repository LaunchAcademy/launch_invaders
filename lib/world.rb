class World

  MAX_SPAWN_DELAY = 100

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

  def next_invader_ready?
    invaders_remaining > 0 && spawn_delay <= 0
  end

  def update
    @spawn_delay -= 1

    if next_invader_ready?
      spawn_new_invader()
    end

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

  def spawn_new_invader
    invader_type = [Invader].sample
    max_x = width - invader_type.size.x
    invaders << invader_type.new(rand(max_x), 0.0)
    @spawn_delay = rand(100)
  end

end
