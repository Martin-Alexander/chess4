module MoveLegalityModule
  def king_safe?(board, move)
  end

  def generate_board(board, move)
    new_board = board.dup
    new_board[move.finish] = new_board[move.start]
    new_board[move.start] = Piece.new(:em)
    new_board
  end

  def local_threats_to_king(new_board)
  end

  def king_safety_scan(new_board)
  end
end