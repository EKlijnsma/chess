# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/rook'

describe Rook do
  let(:id) { 'rook_1' }
  let(:color) { 'white' }
  let(:symbol) { '♜' }
  let(:position) { [0, 0] }
  let(:relative_moves) do
    { up: [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      down: [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      right: [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      left: [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]] }
  end

  subject(:rook) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(rook).to be_a(Piece)
    end

    context 'when initialized' do
      it 'holds the correct array of moves in the up-direction' do
        expect(rook.relative_moves[:up].sort).to eq(relative_moves[:up].sort)
      end
      it 'holds the correct array of moves in the down-direction' do
        expect(rook.relative_moves[:down].sort).to eq(relative_moves[:down].sort)
      end
      it 'holds the correct array of moves in the left-direction' do
        expect(rook.relative_moves[:left].sort).to eq(relative_moves[:left].sort)
      end
      it 'holds the correct array of moves in the right-direction' do
        expect(rook.relative_moves[:right].sort).to eq(relative_moves[:right].sort)
      end
    end
  end

  describe '#update_legal_targets' do
    context 'when the rook is on an empty board' do
      let(:board) { double('board') }

      before do
        allow(board).to receive(:state).and_return(Array.new(8) { Array.new(8) })
      end

      context 'when its position is corner square a1 (coords 0,0)' do
        before do
          rook.move([0, 0])
          rook.update_legal_targets(board)
        end

        it 'can make moves to all squares on the "a-file"' do
          file_a = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
          expect(rook.legal_targets[:up]).to include(*file_a)
        end

        it 'can make moves to all squares on the "1st rank"' do
          rank1 = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
          expect(rook.legal_targets[:right]).to include(*rank1)
        end
      end

      context 'when its position is conrner square h8 (coords 7,7)' do
        before do
          rook.move([7, 7])
          rook.update_legal_targets(board)
        end

        it 'can make moves to all squares on the "h-file"' do
          file = rook.legal_targets[:up] + rook.legal_targets[:down]
          file_h = [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6]]
          expect(file).to include(*file_h)
        end

        it 'can make moves to all squares on the "8th rank"' do
          rank = rook.legal_targets[:left] + rook.legal_targets[:right]
          rank8 = [[0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7]]
          expect(rank).to include(*rank8)
        end
      end

      context 'when its position is center square e4 (coords 4,3)' do
        before do
          rook.move([4, 3])
          rook.update_legal_targets(board)
        end

        it 'can make moves to all squares on the "e-file"' do
          file = rook.legal_targets[:up] + rook.legal_targets[:down]
          file_e = [[4, 0], [4, 1], [4, 2], [4, 4], [4, 5], [4, 6], [4, 7]]
          expect(file).to include(*file_e)
        end

        it 'can make moves to all squares on the "4th rank"' do
          rank = rook.legal_targets[:left] + rook.legal_targets[:right]
          rank4 = [[0, 3], [1, 3], [2, 3], [3, 3], [5, 3], [6, 3], [7, 3]]
          expect(rank).to include(*rank4)
        end
      end
    end

    context 'when some squares are occupied by own pieces' do
      let(:board) { double('board') }
      let(:white_piece) { double(color: 'white') }

      before do
        board_state = Array.new(8) { Array.new(8) }
        board_state[1][2] = white_piece
        allow(board).to receive(:state).and_return(board_state)
      end

      xit 'removes those squares from legal targets' do
        rook.move([0, 0])
        rook.update_legal_targets(board)
        result = [[2, 1]]
        expect(rook.legal_targets).to eq(result)
      end
    end

    context 'when some target squares are occupied by enemy pieces' do
      let(:board) { double('board') }
      let(:white_piece) { double(color: 'white') }
      let(:black_piece) { double(color: 'black') }

      before do
        board_state = Array.new(8) { Array.new(8) }
        board_state[1][2] = white_piece
        board_state[2][1] = black_piece
        allow(board).to receive(:state).and_return(board_state)
      end
      xit 'still sees those squares as legal targets' do
        rook.move([0, 0])
        rook.update_legal_targets(board)
        result = [[2, 1]]
        expect(rook.legal_targets).to eq(result)
      end
    end

    context 'when rook is pinned to the king (when moving would result in checking own king' do
      xit 'does not have any legal targets' do
        # TODO
      end
    end

    context 'when kind is in check' do
      xit 'a target that gets the king out of check is legal' do
        # TODO
      end

      xit 'a target that does not get the king out of check is not legal' do
        # TODO
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
