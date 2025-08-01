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
end
