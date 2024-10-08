# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/piece'

describe Piece do
  let(:id) { 'pawn_1' }
  let(:color) { 'white' }
  let(:symbol) { '♙' }
  let(:position) { [0, 1] }

  subject(:piece) { described_class.new(id, color, symbol, position) }

  describe 'initialize' do
    context 'when initialized with id, color, symbol and position' do
      it 'holds the given id' do
        expect(piece.id).to eq(id)
      end
      it 'holds the given color' do
        expect(piece.color).to eq(color)
      end
      it 'holds the given symbol' do
        expect(piece.symbol).to eq(symbol)
      end
      it 'holds the given position' do
        expect(piece.position).to eq(position)
      end
    end
  end

  describe '#move' do
    let(:destination) { [0, 3] }

    context 'when presented with a move' do
      it 'updates its position correctly' do
        piece.move(destination)
        expect(piece.position).to eq(destination)
      end
    end
  end

  describe '#capture' do
    it 'sets the position to nil (off the board)' do
      piece.capture
      expect(piece.position).to be_nil
    end
  end

  describe '#update_legal_targets' do
    # is different for every piece, so it is defined in the subclasses
  end
end
# rubocop:enable Metrics/BlockLength
