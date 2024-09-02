# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/bishop'

describe Bishop do
  let(:id) { 'bishop_1' }
  let(:color) { 'white' }
  let(:symbol) { '♝' }
  let(:position) { [0, 0] }
  let(:relative_moves) do
    { up_right: [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      down_right: [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      up_left: [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]],
      down_left: [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]] }
  end

  subject(:bishop) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(bishop).to be_a(Piece)
    end

    context 'when initialized' do
      it 'holds the correct array of moves in the up-right-direction' do
        expect(bishop.relative_moves[:up_right].sort).to eq(relative_moves[:up_right].sort)
      end
      it 'holds the correct array of moves in the up-left-direction' do
        expect(bishop.relative_moves[:up_left].sort).to eq(relative_moves[:up_left].sort)
      end
      it 'holds the correct array of moves in the down-right-direction' do
        expect(bishop.relative_moves[:down_right].sort).to eq(relative_moves[:down_right].sort)
      end
      it 'holds the correct array of moves in the down-left-direction' do
        expect(bishop.relative_moves[:down_left].sort).to eq(relative_moves[:down_left].sort)
      end
    end
  end

  describe '#update_legal_targets' do
    context 'when the bishop is on an empty board' do
      let(:board) { double('board') }

      before do
        allow(board).to receive(:state).and_return(Array.new(8) { Array.new(8) })
      end

      context 'when its position is corner square a1 (coords 0,0)' do
        before do
          bishop.move([0, 0])
          bishop.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a1-h8 diagonal' do
          diagonal = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
          expect(bishop.legal_targets[:up_right]).to include(*diagonal)
        end
      end

      context 'when its position is conrner square h8 (coords 7,7)' do
        before do
          bishop.move([7, 7])
          bishop.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a1-h8 diagonal' do
          diagonal = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]]
          expect(bishop.legal_targets[:down_left]).to include(*diagonal)
        end
      end

      context 'when its position is center square e4 (coords 4,3)' do
        before do
          bishop.move([4, 3])
          bishop.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a8-h1 diagonal' do
          diagonal_targets = bishop.legal_targets[:up_left] + bishop.legal_targets[:down_right]
          diagonal = [[0, 7], [1, 6], [2, 5], [3, 4], [5, 2], [6, 1], [7, 0]]
          expect(diagonal).to include(*diagonal_targets)
          expect(diagonal_targets.size).to eq(7)
        end

        it 'can make moves to all squares on the b2-h7 diagonal' do
          diagonal_targets = bishop.legal_targets[:up_right] + bishop.legal_targets[:down_left]
          diagonal = [[1, 0], [2, 1], [3, 2], [5, 4], [6, 5], [7, 6]]
          expect(diagonal).to include(*diagonal_targets)
          expect(diagonal_targets.size).to eq(6)
        end

        it 'has a total of 13 legal target squares' do
          targets = bishop.legal_targets.values.flatten(1)
          expect(targets.size).to eq(13)
        end
      end
    end

    context 'when blocked by own pieces' do
      let(:board) { double('board') }
      let(:white_piece) { double(color: 'white') }

      before do
        bishop.move([0, 2])
      end

      it 'has no legal moves in starting position' do
        board_state = Array.new(8) { Array.new(8) }
        board_state[1][1] = white_piece
        board_state[1][3] = white_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        moves = bishop.legal_targets.values.flatten(1)
        expect(moves.size).to eq(0)
      end

      it 'can move on its diagonal in 1 direction until blocked by an own piece' do
        board_state = Array.new(8) { Array.new(8) }
        board_state[2][4] = white_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        expect(bishop.legal_targets[:up_right].size).to eq(1)
      end

      it 'can move on its diagonal in 2 directions until blocked by an own piece' do
        bishop.move([3, 3])
        board_state = Array.new(8) { Array.new(8) }
        board_state[5][5] = white_piece
        board_state[1][1] = white_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        diagonal = bishop.legal_targets[:up_right] + bishop.legal_targets[:down_left]
        expect(diagonal.size).to eq(2)
      end

      it 'can move in 4 directions until blocked by an own piece' do
        bishop.move([4, 4])
        board_state = Array.new(8) { Array.new(8) }
        board_state[6][6] = white_piece
        board_state[1][1] = white_piece
        board_state[6][2] = white_piece
        board_state[2][6] = white_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        targets = bishop.legal_targets.values.flatten(1)
        expect(targets.size).to eq(5)
      end
    end

    context 'when facing enemy pieces' do
      let(:board) { double('board') }
      let(:black_piece) { double(color: 'black') }

      before do
        bishop.move([0, 2])
      end

      it 'can move on its diagonal in 1 direction until (and including) enemy square' do
        board_state = Array.new(8) { Array.new(8) }
        board_state[2][4] = black_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        expect(bishop.legal_targets[:up_right].size).to eq(2)
      end

      it 'can move on its diagonal in 2 directions until (and including) enemy square' do
        bishop.move([3, 3])
        board_state = Array.new(8) { Array.new(8) }
        board_state[5][5] = black_piece
        board_state[1][1] = black_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        diagonal = bishop.legal_targets[:up_right] + bishop.legal_targets[:down_left]
        expect(diagonal.size).to eq(4)
      end

      it 'can move in 4 directions until (and including) enemy square' do
        bishop.move([4, 4])
        board_state = Array.new(8) { Array.new(8) }
        board_state[6][6] = black_piece
        board_state[1][1] = black_piece
        board_state[6][2] = black_piece
        board_state[2][6] = black_piece
        allow(board).to receive(:state).and_return(board_state)
        bishop.update_legal_targets(board)
        targets = bishop.legal_targets.values.flatten(1)
        expect(targets.size).to eq(9)
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
