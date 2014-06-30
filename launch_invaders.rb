#!/usr/bin/env ruby

require 'gosu'

Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each do |file|
  require file
end

class LaunchInvaders < Gosu::Window
  SCREEN_WIDTH = 1280
  SCREEN_HEIGHT = 720
  INVADER_COUNT = 10

  attr_reader :world

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = 'Launch Invaders'

    @world = World.new(SCREEN_WIDTH, SCREEN_HEIGHT, INVADER_COUNT)
  end

  def update
    world.update
  end

  def draw
    world.invaders.each do |invader|
      draw_rect(invader.bounds, invader.color)
    end

    world.lasers.each do |laser|
      draw_rect(laser.bounds, Gosu::Color::RED)
    end

    draw_rect(world.player.bounds, Gosu::Color::BLUE)
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
      world.start_moving_player(:left)
    when Gosu::KbRight
      world.start_moving_player(:right)
    when Gosu::KbSpace
      world.player_fire_laser
    end
  end

  def button_up(id)
    case id
    when Gosu::KbLeft
      world.stop_moving_player(:left)
    when Gosu::KbRight
      world.stop_moving_player(:right)
    end
  end

  private

  def draw_rect(rect, color)
    draw_quad(
      rect.left, rect.top, color,
      rect.left, rect.bottom, color,
      rect.right, rect.top, color,
      rect.right, rect.bottom, color
      )
  end
end

window = LaunchInvaders.new
window.show
