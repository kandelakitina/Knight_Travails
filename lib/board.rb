# frozen_string_literal: true

class Board
  attr_reader :positions, :size

  def initialize(size = 8)
    @size = size
    @positions = generate_positions(size)
  end

  def generate_positions(size)
    (0...size).flat_map do |row|
      (0...size).map do |col|
        [row, col]
      end
    end
  end

  def valid_move?(position)
    x, y = position
    x.between?(0, size - 1) && y.between?(0, size - 1)
  end
end
