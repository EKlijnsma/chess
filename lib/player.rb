# frozen_string_literal: true

class Player
  attr_accessor :name, :color, :board

  def initialize(name, color)
    self.name = name
    self.color = color
    self.board = nil
    @long_castle = true
    @short_castle = true
  end

  def allowed_long_castle?
    @long_castle
  end

  def allowed_short_castle?
    @short_castle
  end

  def enter_move
    valid_piece = nil
    valid_destination = nil
    until valid_piece
      piece = select_piece
      valid_piece = board.validate_selection(piece, color)
    end
    until valid_destination
      destination = select_destination
      return enter_move if destination == 'cancel'

      valid_destination = board.validate_destination(piece, destination)
    end
    [piece, destination]
  end

  private

  def select_piece
    puts 'Select one of your pieces by entering its square (e.g. "e2"):'
    gets.chomp
  end

  def select_destination
    puts 'Select a destination square (e.g. "e4"), or type "cancel" to select a different piece:'
    gets.chomp
  end
end
