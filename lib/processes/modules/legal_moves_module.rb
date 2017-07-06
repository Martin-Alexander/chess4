module LegalMovesModule
  include Helpers

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
    output = []
    variables = [
      [-1, 1, [square.rank, 7 - square.file].min],
      [-1, -1, [square.rank, square.file].min],
      [1, -1, [7 - square.rank, square.file].min],
      [1, 1, [7 - square.rank, 7 - square.file].min]
    ]
    variables.each do |i| 
      move_along(i[0], i[1], i[2], rank, file, output, board)
    end

    output
  end

  def rook(square)
    []
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

  def descrete_movement(move_translations, square)
    move_translations.each_with_object([]) do |move_translation, output|
      if (square.translate(move_translation) rescue false)
        if @board[square.translate(move_translation)].empty?
          output << Move.new(square, square.translate(move_translation))
        elsif @board[square.translate(move_translation)].color != @turnplayer_color
          output << Move.new(square, square.translate(move_translation), capture: true)
        end
      end
    end
  end

  def move_along(rank_mod, file_mod, sequence_builder, rank, file, output, board)
    piece = board[rank][file]
    (1..sequence_builder).each do |increment|
      if board[rank + increment * rank_mod][file + increment * file_mod].zero?
        output << Move.new([rank, file], [rank + increment * rank_mod, file + increment * file_mod], capture: false)
      elsif board[rank + increment * rank_mod][file + increment * file_mod].color != piece.color
        output << Move.new([rank, file], [rank + increment * rank_mod, file + increment * file_mod], capture: true)
        break
      else
        break
      end
    end
  end

end