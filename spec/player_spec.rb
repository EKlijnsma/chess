# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require_relative '../lib/player'

describe Player do
  let(:color) { 'black' }
  let(:name) { 'John Doe' }
  subject(:player) { described_class.new(name, color) }

  describe '#initialize' do
    context 'when initialized with name and color' do
      it 'initializes with the given player name' do
        expect(player.name).to eq(name)
      end

      it 'initializes with the given color' do
        expect(player.color).to eq(color)
      end

      it 'initializes with the right to castle both long and short' do
        expect(player).to be_allowed_long_castle
        expect(player).to be_allowed_short_castle
      end
    end
  end

  describe '#enter_move' do
    let(:board) { double('board') }

    before do
      allow(player).to receive(:select_piece).and_return('e2')
      allow(player).to receive(:select_destination).and_return('e4')
      allow(board).to receive(:validate_selection).and_return(true)
      allow(board).to receive(:validate_destination).and_return(true)
      allow(player).to receive(:board).and_return(board)
    end

    it 'prompts for piece selection' do
      expect(player).to receive(:select_piece)
      player.enter_move
    end

    it 'prompts for destination selection' do
      expect(player).to receive(:select_destination)
      player.enter_move
    end

    it 'delegates validation of piece selection to the board class' do
      expect(board).to receive(:validate_selection).with('e2', player.color)
      player.enter_move
    end

    it 'delegates validation of destination to the board class' do
      expect(board).to receive(:validate_destination).with('e2', 'e4')
      player.enter_move
    end

    it 'returns a valid move' do
      expect(player.enter_move).to eq(%w[e2 e4])
    end
  end
end
# rubocop:enable Metrics/BlockLength
