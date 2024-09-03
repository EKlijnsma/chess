# frozen_string_literal:true

require_relative 'piece'

class Pawn < Piece
  attr_reader :relative_moves

  def initialize(id, color, symbol, position)
    super
    @relative_moves = { up: [[0, 1], [0, 2]], up_right: [[1, 1]], up_left: [[-1, 1]] }
  end

  def account_for_pieces(targets, board)
    moves = {}
    targets.each do |direction, squares|
      # Get the actual state (content) of the board at all squares
      squares_states = squares.map { |square| board.state[square[0]][square[1]] }

      # make sure every direction exists in the moves output
      moves[direction] = []

      # if in diagonal direction, there is a piece and it is not the same color as self, add the squares to legal moves
      if %i[up_left up_right].include?(direction) && (squares_states[0] && squares_states[0].color != color)
        moves[direction] = squares

      elsif direction == :up
        # if a piece sits at the next square, move on to the next direction
        next if squares_states[0]

        # if it doesnt, add this square
        moves[direction].push(squares[0])
        # add the 2-step move only if current position is on the 1st rank and no piece sits at the target square
        moves[direction].push(squares[1]) if position[1] == 1 && squares_states[1].nil?
      end
    end
    moves
  end

  def account_for_pieces(targets, board)
    moves = {}
    targets.each do |direction, squares|
      # Get the actual state (content) of the board at all squares
      squares_states = squares.map { |square| board.state[square[0]][square[1]] }

      # Set moves
      moves[direction] =
        (direction == :up ? get_upward_moves(direction, squares) : get_diagonal_moves(direction, squares))
    end
    moves
  end

  def get_upward_moves(direction, squares)
    # TODO, returns moves or empty array when no moves
  end

  def get_diagonal_moves(direction, squares)
    # TODO, returns moves or empty array when no moves
  end
end
