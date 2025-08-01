# frozen_string_literal: true

class Board
  attr_reader :positions

  def initialize(size = 8)
    @positions = generate_positions(size)
  end

  def generate_positions(size)
    (0...size).flat_map do |row|
      (0...size).map do |col|
        [row, col]
      end
    end
  end
end
