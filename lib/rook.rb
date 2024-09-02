# frozen_string_literal:true

require_relative 'piece'

class Rook < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = generate_relative_moves
  end

  private

  def generate_relative_moves
    directions = { up: [0, 1], down: [0, -1], right: [1, 0], left: [-1, 0] }
    moves = {}
    directions.each do |key, (dx, dy)|
      moves[key] = (1..7).map { |i| [dx * i, dy * i] }
    end
    moves
  end
end
