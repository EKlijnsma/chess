# frozen_string_literal:true

class Piece
  attr_reader :id, :color, :symbol, :position, :legal_moves

  # Symbols: ♔	♕	♖	♗	♘	♙	♚	♛	♜	♝	♞	♟
  def initialize(id, color, symbol, position)
    @id = id
    @color = color
    @symbol = symbol
    @position = position
    @legal_moves = nil
  end

  def move(destination)
    @position = destination
  end

  def capture
    @position = nil
  end
end
