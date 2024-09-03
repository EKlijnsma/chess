# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/pawn'

describe Pawn do
  let(:id) { 'pawn_1' }
  let(:color) { 'white' }
  let(:symbol) { 'P' }
  let(:position) { [3, 1] }
  let(:relative_moves) do
    { up: [[0, 1], [0, 2]], up_right: [[1, 1]], up_left: [[-1, 1]] }
  end

  subject(:pawn) { described_class.new(id, color, symbol, position) }

  describe '#initialize' do
    it 'inherits from Piece' do
      expect(pawn).to be_a(Piece)
    end

    context 'when initialized' do
      it 'holds the correct array of moves in the up-direction' do
        expect(pawn.relative_moves[:up].sort).to eq(relative_moves[:up].sort)
      end

      it 'holds the correct array of moves in the up-right-direction' do
        expect(pawn.relative_moves[:up_right].sort).to eq(relative_moves[:up_right].sort)
      end

      it 'holds the correct array of moves in the up-left-direction' do
        expect(pawn.relative_moves[:up_left].sort).to eq(relative_moves[:up_left].sort)
      end
    end
  end

  describe '#update_legal_targets' do
    let(:board) { double('board') }
    let(:board_state) { Array.new(8) { Array.new(8) } }
    let(:white_piece) { double(color: 'white') }
    let(:black_piece) { double(color: 'black') }

    before do
      pawn.move([3, 3])
      allow(board).to receive(:state).and_return(board_state)
    end

    context 'when in starting position' do
      it 'has the option to move up by 1 or by 2 squares' do
        pawn.move([3, 1])
        pawn.update_legal_targets(board)
        legal = [[3, 2], [3, 3]]
        expect(pawn.legal_targets.values.flatten(1).sort).to eq(legal.sort)
      end
    end

    context 'when no longer in starting position' do
      it 'can only move up by 1 square' do
        pawn.update_legal_targets(board)
        legal = [[3, 4]]
        expect(pawn.legal_targets.values.flatten(1).sort).to eq(legal.sort)
      end
    end

    context 'when blocked by an own piece on the same file' do
      it 'cannot move in the up-direction' do
        board_state[3][4] = white_piece
        pawn.update_legal_targets(board)
        expect(pawn.legal_targets.values.flatten(1).size).to eq(0)
      end
    end

    context 'when blocked by an opponent on the same file' do
      it 'cannot move in the up-direction' do
        board_state[3][4] = black_piece
        pawn.update_legal_targets(board)
        expect(pawn.legal_targets.values.flatten(1).size).to eq(0)
      end
    end

    context 'when facing enemy in up-left and up-right directions' do
      it 'has the option to move (capture) diagonally' do
        board_state[2][4] = black_piece
        board_state[4][4] = black_piece
        pawn.update_legal_targets(board)
        legal = [[2, 4], [4, 4]]
        expect(pawn.legal_targets.values.flatten(1)).to include(*legal)
      end
    end

    context 'when in position for en passant' do
      context 'when playing with white' do
        xit 'can make an en passant capture if the enemy pawn came from starting position' do
          # TODO
        end

        xit 'can not make an en passant capture if the enemy pawn did not come from starting position' do
          # TODO
        end
      end

      context 'when playing with black' do
        xit 'can make an en passant capture if the enemy pawn came from starting position' do
          # TODO
        end

        xit 'can not make an en passant capture if the enemy pawn did not come from starting position' do
          # TODO
        end
      end
    end

    context 'when reaching the opposite end of the board' do
      xit 'gets promoted to another piece' do
        # TODO
      end

      xit 'prompts for what piece to promote to' do
        # TODO
      end

      xit 'creates a new instance of the chosen piece' do
        # TODO
      end

      xit 'it removes the pawn from the board' do
        # TODO
      end
    end

    context 'when pawn is pinned to the king (when moving would result in checking own king' do
      xit 'does not have any legal targets' do
        # TODO
      end
    end

    context 'when king is in check' do
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
