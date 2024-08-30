# frozen_string_literal: true

require_relative '../lib/knight'

describe Knight do
  let(:id) { 'knight_1' }
  let(:color) { 'white' }
  let(:symbol) { '♞' }
  let(:position) { [1, 0] }
  let(:relative_moves) { [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]] }

  subject(:knight) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(knight).to be_a(Piece)
    end

    it 'holds the correct array of relative moves' do
      expect(knight.relative_moves.sort).to eq(relative_moves.sort)
    end
  end
end
