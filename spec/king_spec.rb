# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/king'

describe Knight do
  let(:id) { 'king' }
  let(:color) { 'white' }
  let(:symbol) { 'K' }
  let(:position) { [4, 0] }
  let(:relative_moves) { [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]] }

  subject(:king) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(king).to be_a(Piece)
    end

    it 'holds the correct array of relative moves' do
      expect(king.relative_moves.sort).to eq(relative_moves.sort)
    end
  end

  describe '#update_legal_targets' do
    context 'when the king is on an empty board' do
      let(:board) { double('board') }

      before do
        allow(board).to receive(:state).and_return(Array.new(8) { Array.new(8) })
      end

      it 'can make all 8 moves from center square e4 (coords 4,3)' do
        king.move([4, 3])
        king.update_legal_targets(board)
        result = [[4, 4], [5, 4], [5, 3], [5, 2], [4, 2], [3, 2], [3, 3], [3, 4]]
        expect(king.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 3 moves in positive direction from corner square a1 (coords 0,0)' do
        king.move([0, 0])
        king.update_legal_targets(board)
        result = [[0, 1],[1, 1], [1, 0]]
        expect(king.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 3 moves in negative direction from corner square h8 (coords 7,7)' do
        king.move([7, 7])
        king.update_legal_targets(board)
        result = [[7, 6], [6, 6], [6, 7]]
        expect(king.legal_targets.sort).to eq(result.sort)
      end

      it 'can make 5 moves from edge square a5 (coords 0,4)' do
        king.move([0, 4])
        king.update_legal_targets(board)
        result = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]]
        expect(king.legal_targets.sort).to eq(result.sort)
      end
    end

    context 'when some target squares are occupied by own pieces' do
      let(:board) { double('board') }
      let(:white_piece) { double(color: 'white') }

      before do
        board_state = Array.new(8) { Array.new(8) }
        board_state[1][1] = white_piece
        allow(board).to receive(:state).and_return(board_state)
      end

      it 'removes those squares from legal targets' do
        king.move([0, 0])
        king.update_legal_targets(board)
        result = [[0, 1], [1, 0]]
        expect(king.legal_targets).to eq(result)
      end
    end

    context 'when some target squares are occupied by enemy pieces' do
      let(:board) { double('board') }
      let(:white_piece) { double(color: 'white') }
      let(:black_piece) { double(color: 'black') }

      before do
        board_state = Array.new(8) { Array.new(8) }
        board_state[1][1] = white_piece
        board_state[0][1] = black_piece
        allow(board).to receive(:state).and_return(board_state)
      end

      it 'still sees those squares as legal targets' do
        king.move([0, 0])
        king.update_legal_targets(board)
        result = [[0, 1], [1, 0]]
        expect(king.legal_targets).to eq(result)
      end
    end

    context 'when in check' do
      xit 'can make a move to a square that is not attacked' do
        # TODO
      end

      xit 'can not make a move to a square that is under attack' do
        # TODO
      end
    end

    context 'when not in check, but all free squares are attacked by enemy pieces' do
      xit 'does not have any legal moves' do
        # TODO
      end
    end

    context 'when no longer having castling rights ' do
      xit 'does not the option to castle long' do
        # TODO
      end
      xit 'does not the option to castle short' do
        # TODO
      end
    end

    context 'when having castling rights ' do
      xit 'can castle long when squares between are empty and not attacked' do
        # TODO
      end

      xit 'can castle short when squares between are empty and not attacked' do
        # TODO
      end

      xit 'can not castle long when leaving from check' do
        # TODO
      end

      xit 'can not castle short when leaving from check' do
        # TODO
      end

      xit 'can not castle long when passing through check' do
        # TODO
      end

      xit 'can not castle short when passing through check' do
        # TODO
      end

      xit 'can not castle long when landing in check' do
        # TODO
      end

      xit 'can not castle short when landing in check' do
        # TODO
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
