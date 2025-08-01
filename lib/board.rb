# frozen_string_literal: true

class Board
  KNIGHT_MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ].freeze

  attr_reader :size

  def initialize(size = 8)
    @size = size
  end

  def valid_move?(position)
    x, y = position
    x.between?(0, size - 1) && y.between?(0, size - 1)
  end

  def possible_moves(position)
    return [] unless valid_move?(position)

    x, y = position
    KNIGHT_MOVES.map { |dx, dy| [x + dx, y + dy] }
                .select { |new_pos| valid_move?(new_pos) }
  end
end
