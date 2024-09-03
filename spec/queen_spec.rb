# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/queen'

describe Queen do
  let(:id) { 'queen_1' }
  let(:color) { 'white' }
  let(:symbol) { 'Q' }
  let(:position) { [0, 3] }
  let(:relative_moves) do
    { up: [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]],
      up_right: [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]],
      right: [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]],
      down_right: [[1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7]],
      down: [[0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]],
      down_left: [[-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]],
      left: [[-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0]],
      up_left: [[-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7]] }
  end

  subject(:queen) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(queen).to be_a(Piece)
    end

    context 'when initialized' do
      it 'holds the correct array of moves in the up-direction' do
        expect(queen.relative_moves[:up].sort).to eq(relative_moves[:up].sort)
      end
      it 'holds the correct array of moves in the down-direction' do
        expect(queen.relative_moves[:down].sort).to eq(relative_moves[:down].sort)
      end
      it 'holds the correct array of moves in the left-direction' do
        expect(queen.relative_moves[:left].sort).to eq(relative_moves[:left].sort)
      end
      it 'holds the correct array of moves in the right-direction' do
        expect(queen.relative_moves[:right].sort).to eq(relative_moves[:right].sort)
      end
      it 'holds the correct array of moves in the up-right-direction' do
        expect(queen.relative_moves[:up_right].sort).to eq(relative_moves[:up_right].sort)
      end
      it 'holds the correct array of moves in the up-left-direction' do
        expect(queen.relative_moves[:up_left].sort).to eq(relative_moves[:up_left].sort)
      end
      it 'holds the correct array of moves in the down-right-direction' do
        expect(queen.relative_moves[:down_right].sort).to eq(relative_moves[:down_right].sort)
      end
      it 'holds the correct array of moves in the down-left-direction' do
        expect(queen.relative_moves[:down_left].sort).to eq(relative_moves[:down_left].sort)
      end
    end
  end

  describe '#update_legal_targets' do
    context 'when the queen is on an empty board' do
      let(:board) { double('board') }

      before do
        allow(board).to receive(:state).and_return(Array.new(8) { Array.new(8) })
      end

      context 'when its position is corner square a1 (coords 0,0)' do
        before do
          queen.move([0, 0])
          queen.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a1-h8 diagonal' do
          diagonal = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
          expect(queen.legal_targets[:up_right]).to include(*diagonal)
        end

        it 'can make moves to all squares on the "a-file"' do
          file_a = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
          expect(queen.legal_targets[:up]).to include(*file_a)
        end

        it 'can make moves to all squares on the "1st rank"' do
          rank1 = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
          expect(queen.legal_targets[:right]).to include(*rank1)
        end
      end

      context 'when its position is conrner square h8 (coords 7,7)' do
        before do
          queen.move([7, 7])
          queen.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a1-h8 diagonal' do
          diagonal = [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]]
          expect(queen.legal_targets[:down_left]).to include(*diagonal)
        end

        it 'can make moves to all squares on the "h-file"' do
          file = queen.legal_targets[:up] + queen.legal_targets[:down]
          file_h = [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6]]
          expect(file).to include(*file_h)
        end

        it 'can make moves to all squares on the "8th rank"' do
          rank = queen.legal_targets[:left] + queen.legal_targets[:right]
          rank8 = [[0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7]]
          expect(rank).to include(*rank8)
        end
      end

      context 'when its position is center square e4 (coords 4,3)' do
        before do
          queen.move([4, 3])
          queen.update_legal_targets(board)
        end

        it 'can make moves to all squares on the a8-h1 diagonal' do
          diagonal_targets = queen.legal_targets[:up_left] + queen.legal_targets[:down_right]
          diagonal = [[0, 7], [1, 6], [2, 5], [3, 4], [5, 2], [6, 1], [7, 0]]
          expect(diagonal).to include(*diagonal_targets)
          expect(diagonal_targets.size).to eq(7)
        end

        it 'can make moves to all squares on the b2-h7 diagonal' do
          diagonal_targets = queen.legal_targets[:up_right] + queen.legal_targets[:down_left]
          diagonal = [[1, 0], [2, 1], [3, 2], [5, 4], [6, 5], [7, 6]]
          expect(diagonal).to include(*diagonal_targets)
          expect(diagonal_targets.size).to eq(6)
        end

        it 'can make moves to all squares on the "e-file"' do
          file = queen.legal_targets[:up] + queen.legal_targets[:down]
          file_e = [[4, 0], [4, 1], [4, 2], [4, 4], [4, 5], [4, 6], [4, 7]]
          expect(file).to include(*file_e)
        end

        it 'can make moves to all squares on the "4th rank"' do
          rank = queen.legal_targets[:left] + queen.legal_targets[:right]
          rank4 = [[0, 3], [1, 3], [2, 3], [3, 3], [5, 3], [6, 3], [7, 3]]
          expect(rank).to include(*rank4)
        end

        it 'has a total of 27 legal target squares' do
          targets = queen.legal_targets.values.flatten(1)
          expect(targets.size).to eq(27)
        end
      end
    end

    context 'when blocked by own pieces' do
      let(:board) { double('board') }
      let(:board_state) { Array.new(8) { Array.new(8) } }
      let(:white_piece) { double(color: 'white') }

      before do
        queen.move([3, 3])
        allow(board).to receive(:state).and_return(board_state)
      end

      it 'has no legal moves in starting position' do
        queen.move([0, 3])
        board_state[0][2] = white_piece
        board_state[0][4] = white_piece
        board_state[1][2] = white_piece
        board_state[1][3] = white_piece
        board_state[1][4] = white_piece

        queen.update_legal_targets(board)
        moves = queen.legal_targets.values.flatten(1)
        expect(moves.size).to eq(0)
      end

      it 'can move in the up direction until blocked by an own piece' do
        board_state[3][5] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up].size).to eq(1)
      end

      it 'can move in the up-right direction until blocked by an own piece' do
        board_state[5][5] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up_right].size).to eq(1)
      end

      it 'can move in the right direction until blocked by an own piece' do
        board_state[5][3] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:right].size).to eq(1)
      end

      it 'can move in the down-right direction until blocked by an own piece' do
        board_state[5][1] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down_right].size).to eq(1)
      end

      it 'can move in the down direction until blocked by an own piece' do
        board_state[3][1] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down].size).to eq(1)
      end

      it 'can move in the down-left direction until blocked by an own piece' do
        board_state[1][1] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down_left].size).to eq(1)
      end

      it 'can move in the left direction until blocked by an own piece' do
        board_state[1][3] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:left].size).to eq(1)
      end

      it 'can move in the up-left direction until blocked by an own piece' do
        board_state[1][5] = white_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up_left].size).to eq(1)
      end
    end

    context 'when facing enemy pieces' do
      let(:board) { double('board') }
      let(:board_state) { Array.new(8) { Array.new(8) } }
      let(:black_piece) { double(color: 'black') }

      before do
        queen.move([3, 3])
        allow(board).to receive(:state).and_return(board_state)
      end

      it 'can move in the up direction until (and including) an enemy pieces\'s square' do
        board_state[3][5] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up].size).to eq(1)
      end

      it 'can move in the up-right direction until (and including) an enemy pieces\'s square' do
        board_state[5][5] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up_right].size).to eq(1)
      end

      it 'can move in the right direction until (and including) an enemy pieces\'s square' do
        board_state[5][3] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:right].size).to eq(1)
      end

      it 'can move in the down-right direction until (and including) an enemy pieces\'s square' do
        board_state[5][1] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down_right].size).to eq(1)
      end

      it 'can move in the down direction until (and including) an enemy pieces\'s square' do
        board_state[3][1] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down].size).to eq(1)
      end

      it 'can move in the down-left direction until (and including) an enemy pieces\'s square' do
        board_state[1][1] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:down_left].size).to eq(1)
      end

      it 'can move in the left direction until (and including) an enemy pieces\'s square' do
        board_state[1][3] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:left].size).to eq(1)
      end

      it 'can move in the up-left direction until (and including) an enemy pieces\'s square' do
        board_state[1][5] = black_piece
        queen.update_legal_targets(board)
        expect(queen.legal_targets[:up_left].size).to eq(1)
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
