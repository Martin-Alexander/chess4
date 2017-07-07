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

  def continuous_movement(variables, starting_square)

    output = []
    rank_mod, file_mod, limit = continuous_movement_variables_setup(variables)

    (1..limit).to_a.each do |increment|
      current_square = starting_square.translate(rank: increment * rank_mod, file: increment * file_mod)

      if @board[current_square].empty?
        output << Move.new(starting_square, current_square)
      elsif @board[current_square].color != @turnplayer_color
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
end