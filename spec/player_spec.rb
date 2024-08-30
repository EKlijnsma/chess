# frozen_string_literal: true

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
end
