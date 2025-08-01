# frozen_string_literal: true

require_relative 'lib/board'

board = Board.new
board.knight_moves([2, 3], [6, 7])
