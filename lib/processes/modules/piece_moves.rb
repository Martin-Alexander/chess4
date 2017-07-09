module PieceMovesModule
  include PieceMovesHelpersModule
  include ChessHelpersModule

  def pawn(square)
    output = []
    move_one, move_two = direction_indepenedent_pawn_rank_advance

    # Double and single rank advance
    if pawn_can_single_advance(square, move_one)
      output << Move.new_pawn_move(square, square.translate( rank: move_one, file: 0 ))
      if pawn_can_double_advance(square, move_two)
        output << Move.new_pawn_move(square, square.translate(rank: move_two, file: 0 ), double_advance: true)
      end
    end

    # Regular right capture
    if pawn_can_capture_right(square, move_one)
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true)
    end
    
    # Regular left capture
    if pawn_can_capture_left(square, move_one)
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true)
    end

    # En passant right capture
    if pawn_can_en_passant_capture_right(square, move_one)
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: 1), capture: true, en_passant_capture: true)
    end      

    # En passant left capture
    if pawn_can_en_passant_capture_left(square, move_one)
      output << Move.new_pawn_move(square, square.translate(rank: move_one, file: -1), capture: true, en_passant_capture: true)
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
      { rank_modifier: 0, file_modifier: -1, square_limit: square.file - 1},
      { rank_modifier: 0, file_modifier: 1, square_limit: 8 - square.file}
    ]
    output = variables_array.map { |variables| continuous_movement(variables, square) }.flatten
  end

  def queen(square)
    variables_array = [
      { rank_modifier: 1, file_modifier: 1, square_limit: [8 - square.rank, 8 - square.file].min},
      { rank_modifier: -1, file_modifier: 1, square_limit: [square.rank - 1, 8 - square.file].min},
      { rank_modifier: 1, file_modifier: -1, square_limit: [8 - square.rank, square.file - 1].min},
      { rank_modifier: -1, file_modifier: -1, square_limit: [square.rank - 1, square.file - 1].min},
      { rank_modifier: 1, file_modifier: 0, square_limit: 8 - square.rank},
      { rank_modifier: -1, file_modifier: 0, square_limit: square.rank - 1},
      { rank_modifier: 0, file_modifier: -1, square_limit: square.file - 1},
      { rank_modifier: 0, file_modifier: 1, square_limit: 8 - square.file}
    ]      
    output = variables_array.map { |variables| continuous_movement(variables, square) }.flatten
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
      {rank: -1, file: -1}
    ]
    descrete_movement(king_move_translations, square)
  end
end