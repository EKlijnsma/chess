# frozen_string_literal:true

require_relative 'piece'

class Knight < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  private

  def exclude_own_piece_positions(targets, board)
    targets.select do |target|
      target_state = board.state[target[0]][target[1]]
      target_state.nil? || target_state.color != color
    end
  end
end
