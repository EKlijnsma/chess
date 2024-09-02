# frozen_string_literal:true

class Piece
  attr_reader :id, :color, :symbol, :position, :legal_targets

  # Symbols: ♔	♕	♖	♗	♘	♙	♚	♛	♜	♝	♞	♟
  def initialize(id, color, symbol, position)
    @id = id
    @color = color
    @symbol = symbol
    @position = position
    @legal_targets = nil
  end

  def move(destination)
    @position = destination
  end

  def capture
    @position = nil
  end

  def update_legal_targets(board)
    targets = generate_on_board_targets
    @legal_targets = account_for_pieces(targets, board)
  end

  def generate_on_board_targets
    result = {}
    @relative_moves.each do |direction, squares|
      targets = []
      squares.each do |move|
        x = position[0] + move[0]
        y = position[1] + move[1]
        next unless x.between?(0, 7) && y.between?(0, 7)

        targets << [x, y]
      end
      result[direction] = targets
    end
    result
  end

  def account_for_pieces(targets, board)
    moves = {}
    targets.each do |direction, squares|
      squares_states = squares.map { |square| board.state[square[0]][square[1]] }
      first_piece = squares_states.find { _1 }
      if first_piece.nil?
        # if no piece was found, take the entire array
        moves[direction] = squares
      else
        i = squares_states.index(first_piece)
        # if piece has the same color, only take the squares before it
        # if piece has enemy color, take the squares before it, and the pieces' square included
        slice = (first_piece.color == color ? squares[0..i - 1] : squares[0..i])
        moves[direction] = slice
      end
    end
    moves
  end
end
