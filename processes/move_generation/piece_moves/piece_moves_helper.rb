module PieceMovesHelpersModule

  def descrete_movement(move_translations, square)
    move_translations.each_with_object([]) do |move_translation, output|
      if (square.translate(move_translation) rescue false)
        if @board[square.translate(move_translation)].empty?
          output << Move.new(square, square.translate(move_translation))
        elsif @board[square.translate(move_translation)].color != turn_player_color
          output << Move.new(square, square.translate(move_translation), capture: true)
        end
      end
    end
  end

  def continuous_movement(variables, starting_square)
    output = []
    rank_mod, file_mod, limit = continuous_movement_variables_setup(variables)

    (1..limit).to_a.each do |increment|
      current_square = starting_square.translate(rank: increment * rank_mod, file: increment * file_mod)
      if @board[current_square].empty?
        output << Move.new(starting_square, current_square)
      elsif @board[current_square].color != turn_player_color
        output << Move.new(starting_square, current_square, capture: true)
        break
      else
        break
      end
    end

    output
  end

  def continuous_movement_variables_setup(variables)
    [variables[:rank_modifier], variables[:file_modifier], variables[:square_limit]]
  end

  def direction_indepenedent_pawn_rank_advance
    [white_to_move ? 1 : -1, white_to_move ? 2 : -2]
  end

  def pawn_can_double_advance(square, move_two)
    (white_to_move ? (square.rank == 2) : (square.rank == 7)) &&
    @board[square.rank + move_two, square.file].empty?
  end

  def pawn_can_single_advance(square, move_one)
    (white_to_move ? (square.rank < 8) : (square.rank > 1)) &&
    @board[square.rank + move_one, square.file].empty?
  end

  def pawn_can_capture_right(square, move_one)
    (white_to_move ? (square.rank < 8) : (square.rank > 1)) &&
    square.file < 8 &&
    !@board[square.rank + move_one, square.file + 1].empty? &&
    @board[square.rank + move_one, square.file + 1].color != turn_player_color
  end

  def pawn_can_capture_left(square, move_one)
    (white_to_move ? (square.rank < 8) : (square.rank > 1)) &&
    square.file > 1 &&
    !@board[square.rank + move_one, square.file - 1].empty? &&
    @board[square.rank + move_one, square.file - 1].color != turn_player_color
  end

  def pawn_can_en_passant_capture_right(square, move_one)
    (white_to_move ? (square.rank < 8) : (square.rank > 1)) &&
    square.file < 8 &&
    square.translate(rank: move_one, file: 1).symbol == en_passent_square
  end

  def pawn_can_en_passant_capture_left(square, move_one)
    (white_to_move ? (square.rank < 8) : (square.rank > 1)) &&
    square.file > 1 &&   
    square.translate(rank: move_one, file: -1).symbol == en_passent_square
  end
end