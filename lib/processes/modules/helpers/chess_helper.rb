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
end