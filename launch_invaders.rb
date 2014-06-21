#!/usr/bin/env ruby
require 'gosu'
require_relative 'world'

class LaunchInvaders < Gosu::Window
  SCREEN_WIDTH = 640
  SCREEN_HEIGHT = 480

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = 'Launch Invaders'

    @world = World.new(SCREEN_WIDTH, SCREEN_HEIGHT, 10)
  end

  def update
    @world.update
  end

  def draw
    @world.invaders.each do |invader|
      draw_rect(invader.bounds, Gosu::Color::WHITE)
    end

    @world.lasers.each do |laser|
      draw_rect(laser.bounds, Gosu::Color::RED)
    end

    draw_rect(@world.player.bounds, Gosu::Color::BLUE)
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
      @world.player_accelerate(:left)
    when Gosu::KbRight
      @world.player_accelerate(:right)
    when Gosu::KbSpace
      @world.player_fire_laser
    end
  end

  def button_up(id)
    case id
    when Gosu::KbLeft
      @world.player_decelerate(:left)
    when Gosu::KbRight
      @world.player_decelerate(:right)
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
