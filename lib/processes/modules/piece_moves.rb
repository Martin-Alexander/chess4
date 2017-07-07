module PieceMovesModule
  include PieceMovesHelpersModule
  include ChessHelpersModule

  def pawn(square)
    output = []
    rank, file = square.rank, square.file

    # Direction indepenedent rank advance 
    move_one = @game_state.white_to_move ? 1 : -1
    move_two = @game_state.white_to_move ? 2 : -2

    # Double and single rank advance
    if (@board[rank + move_one, file] rescue false) && @board[rank + move_one, file].empty?
      output << Move.new_pawn_move(square, square.translate( rank: move_one, file: 0 ))
      if (@board[rank + move_two, file] rescue false) && ((square.rank == 2 && @turnplayer_color == :white) || (square.rank == 7 && @turnplayer_color == :black)) && 
        @board[rank + move_two, file].empty?
        output << Move.new_pawn_move(square, square.translate(rank: move_two, file: 0 ), double_advance: true)
      end
    end

    # Regular capture
    left_capture = @board[rank + move_one, file - 1] rescue false
    if left_capture && !left_capture.empty? && left_capture.color != @turnplayer_color
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true)
    end
    right_capture = @board[rank + move_one, file + 1] rescue false
    if right_capture && !right_capture.empty? && right_capture.color != @turnplayer_color
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true)
    end
    
    # En passant capture
    if left_capture && square.translate(rank: move_one, file: -1).symbol == @game_state.en_passant
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true, en_passant_capture: true)
    end
    if right_capture && square.translate(rank: move_one, file: 1).symbol == @game_state.en_passant
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true, en_passant_capture: true)
    end      

    output.flatten
  end

  def knight(square)
    knight_move_translations = [
      {rank: 2, file: 1},
      {rank: 2, file: -1},
      {rank: 1, file: 2},
      {rank: 1, file: -2},
      {rank: -2, file: 1},
      {rank: -2, file: -1},
      {rank: -1, file: 2},
      {rank: -1, file: -2}
    ]

    descrete_movement(knight_move_translations, square)
  end

  def bishop(square)
    variables_array = [
      { rank_modifier: 1, file_modifier: 1, square_limit: [8 - square.rank, 8 - square.file].min},
      { rank_modifier: -1, file_modifier: 1, square_limit: [square.rank - 1, 8 - square.file].min},
      { rank_modifier: 1, file_modifier: -1, square_limit: [8 - square.rank, square.file - 1].min},
      { rank_modifier: -1, file_modifier: -1, square_limit: [square.rank - 1, square.file - 1].min}
    ]
    output = variables_array.map { |variables| continuous_movement(variables, square) }.flatten
  end

  def rook(square)
    variables_array = [
      { rank_modifier: 1, file_modifier: 0, square_limit: 8 - square.rank},
      { rank_modifier: -1, file_modifier: 0, square_limit: square.rank - 1},
      { rank_modifier: 0, file_modifier: -1, square_limit: square.file -1},
      { rank_modifier: 0, file_modifier: 1, square_limit: 8 - square.file}
    ]
    output = variables_array.map { |variables| continuous_movement(variables, square) }.flatten
  end

  def queen(square)
    []
  end

  def king(square)
    king_move_translations = [
      {rank: 1, file: 0},
      {rank: 1, file: 1},
      {rank: 1, file: -1},
      {rank: 0, file: 1},
      {rank: 0, file: -1},
      {rank: -1, file: 0},
      {rank: -1, file: 1},
      {rank: -1, file: -1},
    ]

    descrete_movement(king_move_translations, square)
  end
end