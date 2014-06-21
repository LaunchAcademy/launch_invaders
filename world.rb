require_relative 'player'
require_relative 'invader'

class World
  attr_reader :invaders, :player, :lasers

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
    if @invaders_remaining > 0
      if @spawn_delay <= 0
        @invaders << Invader.new(@width)
        @spawn_delay = rand(100)
        @invaders_remaining -= 1
      else
        @spawn_delay -= 1
      end
    end

    @invaders.each do |invader|
      invader.move()
    end

    @lasers.each do |laser|
      laser.move()
    end

    @player.move()

    @lasers.each do |laser|
      @invaders.each do |invader|
        if laser.bounds.overlaps?(invader.bounds)
          laser.destroy()
          invader.destroy()
          break
        end
      end
    end

    @lasers = @lasers.reject { |laser| laser.destroyed? }
    @invaders = @invaders.reject { |invader| invader.destroyed? }
  end

  def player_accelerate(direction)
    @player.accelerate(direction)
  end

  def player_decelerate(direction)
    @player.decelerate(direction)
  end

  def player_fire_laser
    @lasers << @player.fire_laser
  end
end
