# frozen_string_literal:true

require_relative 'piece'

class Knight < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
end
