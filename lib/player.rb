# frozen_string_literal: true

class Player
  attr_accessor :name, :color

  def initialize(name, color)
    self.name = name
    self.color = color
    @long_castle = true
    @short_castle = true
  end

  def allowed_long_castle?
    @long_castle
  end

  def allowed_short_castle?
    @short_castle
  end
end
