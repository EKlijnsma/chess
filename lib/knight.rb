# frozen_string_literal:true

require_relative 'piece'

class Knight < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def update_legal_targets(board)
    result = []
    @relative_moves.each do |move|
      x = position[0] + move[0]
      y = position[1] + move[1]
      next unless x.between?(0, 7) && y.between?(0, 7)

      result.append([x, y])
    end
    @legal_targets = result
  end
end
