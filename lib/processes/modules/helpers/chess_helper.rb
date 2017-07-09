module ChessHelpersModule

  def each_rankfile
    (1..8).each do |rank|
      (1..8).each do |file|
        yield rank, file
      end
    end
    nil
  end

  def each_square
    ('a'..'h').each do |letter|
      (1..8).each do |number|
        yield (letter + number.to_s).to_sym
      end
    end
  end

  def white_to_move
    @game_state.white_to_move
  end

  def turn_player_color
    white_to_move ? :white : :black
  end

  def en_passent_square
    @game_state.en_passant
  end
end