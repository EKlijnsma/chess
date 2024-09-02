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
    @legal_targets = exclude_own_piece_positions(targets, board)
  end

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
end
