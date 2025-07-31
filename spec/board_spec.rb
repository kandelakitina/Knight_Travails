# spec/board_spec.rb
require_relative '../lib/board' # adjust path as needed

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates an 8x8 grid of coordinate pairs' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |row| row.size == 8 }).to be true

      # Check a few sample values
      expect(board.grid[0][0]).to eq([0, 0])
      expect(board.grid[7][7]).to eq([7, 7])
    end
  end
end
