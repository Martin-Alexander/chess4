module PieceMovesHelpersModule

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
  
  def move_along(rank_incrementer, file_mod, square_limit, starting_square)
    # piece = board[rank][file]
    output = []
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