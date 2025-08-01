# frozen_string_literal: true

class Board
  MOVES = [
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
    MOVES.map { |dx, dy| [x + dx, y + dy] }
         .select { |new_pos| valid_move?(new_pos) }
  end

  require 'set'

  def knight_moves(start, target)
    return [] unless valid_move?(start) && valid_move?(target)
    return [start] if start == target

    visited = Set.new
    queue = [[start]]

    until queue.empty?
      path = queue.shift
      current = path.last

      return print_path(path) if current == target

      possible_moves(current).each do |move|
        next if visited.include?(move)

        visited << move
        queue << (path + [move])
      end
    end
  end

  def print_path(path)
    puts "Your path is #{path.first} to #{path.last}. You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |move| puts move.inspect }
  end
end
