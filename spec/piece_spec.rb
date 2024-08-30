# frozen_string_literal: true

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
    context 'when presented with a move' do
      it 'updates its position correctly' do
        let(:destination) { [0, 3] }

        piece.move(destination)
        expect(piece.position).to eq(destination)
      end
    end
  end

  describe '#update_legal_moves' do
  end
end
