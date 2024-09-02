# frozen_string_literal:true

require_relative 'piece'

class Bishop < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = generate_relative_moves
  end

  private

  def generate_relative_moves
    directions = { up_right: [1, 1], down_right: [1, -1], up_left: [-1, 1], down_left: [-1, -1] }
    moves = {}
    directions.each do |key, (dx, dy)|
      moves[key] = (1..7).map { |i| [dx * i, dy * i] }
    end
    moves
  end
end
