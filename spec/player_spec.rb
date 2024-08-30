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
    context 'when valid input is given' do
      before do
        allow(player).to receive(:prompt_for_input).and_return('e5')
        allow(player).to receive(:validate_input).and_return(true)
      end

      it 'prompts for input once' do
        expect(player).to receive(:prompt_for_input).once
        player.enter_move
      end

      it 'validates given input' do
        expect(player).to receive(:validate_input)
        player.enter_move
      end

      it 'returns valid input' do
        expect(player.enter_move).to eq('e5')
      end
    end

    context 'when invalid input is given twice' do
      before do
        allow(player).to receive(:prompt_for_input).and_return('q16', 'string', 'e5')
        allow(player).to receive(:validate_input).and_return(false, false, true)
      end

      it 'prompts for input 3 times' do
        expect(player).to receive(:prompt_for_input).exactly(3).times
        player.enter_move
      end

      it 'validates given input 3 times' do
        expect(player).to receive(:validate_input).exactly(3).times
        player.enter_move
      end

      it 'returns the valid input' do
        expect(player.enter_move).to eq('e5')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
