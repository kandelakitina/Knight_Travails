# spec/board_spec.rb
require_relative '../lib/board'

RSpec.describe Board do
  context 'with default board size (8x8)' do
    subject(:board) { described_class.new }

    describe '#valid_move?' do
      it 'returns true for positions within bounds' do
        expect(board.valid_move?([0, 0])).to be true
        expect(board.valid_move?([7, 7])).to be true
        expect(board.valid_move?([3, 4])).to be true
      end

      it 'returns false for positions out of bounds' do
        expect(board.valid_move?([-1, 0])).to be false
        expect(board.valid_move?([0, 8])).to be false
        expect(board.valid_move?([8, 8])).to be false
        expect(board.valid_move?([10, 2])).to be false
      end
    end

    describe '#possible_moves' do
      it 'returns only valid knight moves from a central position' do
        result = board.possible_moves([4, 4])
        expected_moves = [
          [5, 6], [5, 2], [3, 6], [3, 2],
          [6, 5], [6, 3], [2, 5], [2, 3]
        ]
        expect(result).to match_array(expected_moves)
      end

      it 'returns only in-bounds knight moves from a corner position (0, 0)' do
        result = board.possible_moves([0, 0])
        expect(result).to match_array([[1, 2], [2, 1]])
      end

      it 'returns valid knight moves from edge position (0, 4)' do
        result = board.possible_moves([0, 4])
        expect(result).to match_array([[1, 6], [2, 5], [2, 3], [1, 2]])
      end

      it 'returns valid knight moves for a custom 10x10 board near the edge' do
        custom_board = described_class.new(10)
        result = custom_board.possible_moves([9, 9])
        expect(result).to match_array([[7, 8], [8, 7]])
      end

      it 'returns an empty array for positions outside the board' do
        result = board.possible_moves([-1, -1])
        expect(result).to eq([])
      end
    end
  end

  context 'with a custom board size' do
    subject(:board) { described_class.new(10) }

    it 'allows valid moves up to the new size' do
      expect(board.valid_move?([9, 9])).to be true
      expect(board.valid_move?([10, 10])).to be false
    end
  end
end
