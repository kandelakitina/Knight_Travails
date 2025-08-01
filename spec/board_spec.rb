# spec/board_spec.rb
require_relative '../lib/board' # adjust path as needed

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates an array of all coordinate pairs on an 8x8 board' do
      expect(board.positions.size).to eq(64)
      expect(board.positions).to include([0, 0], [3, 4], [7, 7])

      # Check uniqueness and validity
      expect(board.positions.uniq.size).to eq(64)
      expect(board.positions.all? { |x, y| x.between?(0, 7) && y.between?(0, 7) }).to be true
    end
  end

  context 'with a custom board size' do
    subject(:board) { described_class.new(10) }

    it 'accepts valid positions up to the new size' do
      expect(board.valid_move?([9, 9])).to be true
      expect(board.valid_move?([10, 10])).to be false
    end
  end

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

    it 'excludes out-of-bounds moves from a corner position' do
      result = board.possible_moves([0, 0])
      expected_moves = [
        [1, 2], [2, 1]
      ]
      expect(result).to match_array(expected_moves)
    end

    it 'returns an empty array if no moves are valid (e.g. from [-1, -1])' do
      result = board.possible_moves([-1, -1])
      expect(result).to eq([])
    end
  end
end
