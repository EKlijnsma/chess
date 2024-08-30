# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

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

  describe '#update_legal_targets' do
    before do
      let(:board) { double('board') }
      allow(board).to receive(:state).and_return(Array.new(8) { Array.new(8) })
    end

    context 'when the knight is on an empty board' do
      it 'can make all 8 moves from center square e4 (coords 4,3)' do
        knight.move([4, 3])
        knight.update_legal_targets(board)
        result = [[5, 5], [5, 1], [3, 5], [3, 1], [6, 4], [6, 2], [2, 4], [2, 2]]
        expect(knight.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 2 moves in positive direction from corner square a1 (coords 0,0)' do
        knight.move([0, 0])
        knight.update_legal_targets(board)
        result = [[1, 2], [2, 1]]
        expect(knight.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 2 moves in negative direction from corner square h8 (coords 7,7)' do
        knight.move([7, 7])
        knight.update_legal_targets(board)
        result = [[5, 6], [6, 5]]
        expect(knight.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 4 moves from edge square a5 (coords 0,4)' do
        knight.move([0, 4])
        knight.update_legal_targets(board)
        result = [[1, 6], [1, 2], [2, 5], [2, 3]]
        expect(knight.legal_targets.sort).to eq(result.sort)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
