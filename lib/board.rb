# frozen_string_literal: true

class Board
  attr_reader :grid

  def initialize(size = 8)
    @grid = setup_grid(size)
  end

  def setup_grid(size)
    Array.new(size) do |row|
      Array.new(size) do |col|
        [row, col]
      end
    end
  end
end
