# frozen_string_literal:true

require_relative 'piece'

class Pawn < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = { up: [[0, 1], [0, 2]], up_right: [[1, 1]], up_left: [[-1, 1]] }
  end
end
