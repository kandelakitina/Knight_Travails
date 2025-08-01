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
  describe '#knight_moves' do
    context 'with a custom board size' do
      subject(:board) { described_class.new(10) }

      it 'allows valid moves up to the new size' do
        expect(board.valid_move?([9, 9])).to be true
        expect(board.valid_move?([10, 10])).to be false
      end
    end

    context 'when moving from one position to another' do
      subject(:board) { described_class.new }

      it 'returns the shortest path from [0, 0] to [1, 2]' do
        result = board.knight_moves([0, 0], [1, 2])
        expect(result).to eq([[0, 0], [1, 2]])
      end

      it 'returns the shortest path from [0, 0] to [3, 3]' do
        result = board.knight_moves([0, 0], [3, 3])
        expect(result).to match_array([[0, 0], [2, 1], [3, 3]]) | match_array([[0, 0], [1, 2], [3, 3]])
      end

      it 'returns the shortest path from [3, 3] to [0, 0]' do
        result = board.knight_moves([3, 3], [0, 0])
        expect(result).to match_array([[3, 3], [2, 1], [0, 0]]) | match_array([[3, 3], [1, 2], [0, 0]])
      end

      it 'returns a valid shortest path from [0, 0] to [7, 7]' do
        result = board.knight_moves([0, 0], [7, 7])

        # Check that the path length is correct (should be 7 moves for the shortest path)
        expect(result.length).to eq(7)

        # Check that the path starts at [0, 0] and ends at [7, 7]
        expect(result.first).to eq([0, 0])
        expect(result.last).to eq([7, 7])

        # The actual path should match one of the two valid shortest paths
        expected_arrays = [
          [[0, 0], [2, 1], [4, 2], [6, 3], [4, 4], [6, 5], [7, 7]],
          [[0, 0], [2, 1], [4, 2], [6, 3], [7, 5], [5, 6], [7, 7]],
          [[0, 0], [1, 2], [2, 4], [3, 6], [4, 4], [5, 6], [7, 7]]
        ]

        expect(result).to(satisfy { |r| expected_arrays.any? { |array| r == array } })
      end
    end

    context 'when starting and ending on the same position' do
      subject(:board) { described_class.new }

      it 'returns a path with a single square if the start and end positions are the same' do
        result = board.knight_moves([0, 0], [0, 0])
        expect(result).to eq([[0, 0]])
      end
    end

    context 'edge cases' do
      subject(:board) { described_class.new }

      it 'returns an empty array if the input is invalid' do
        result = board.knight_moves([10, 10], [0, 0])
        expect(result).to eq([])
      end

      it 'returns an empty array for invalid destination' do
        result = board.knight_moves([0, 0], [8, 8])
        expect(result).to eq([])
      end
    end
  end
end
