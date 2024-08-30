# frozen_string_literal:true

require_relative 'piece'

class Knight < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end

  def update_legal_targets(board)
    targets = generate_on_board_targets
    @legal_targets = exclude_own_piece_positions(targets, board)
  end

  private

  def generate_on_board_targets
    result = []
    @relative_moves.each do |move|
      x = position[0] + move[0]
      y = position[1] + move[1]
      next unless x.between?(0, 7) && y.between?(0, 7)

      result << [x, y]
    end
    result
  end

  def exclude_own_piece_positions(targets, board)
    targets.select do |target|
      target_state = board.state[target[0]][target[1]]
      target_state.nil? || target_state.color != color
    end
  end
end
