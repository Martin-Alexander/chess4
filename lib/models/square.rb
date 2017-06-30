class Square < Chess
  attr_reader :rank, :file, :symbol

  def initialize(rank_or_symbol, file = nil)
    if file
      @rank = rank_or_symbol
      @file = file
      @symbol = to_square(@rank, @file)
    else
      @rank = to_rankfile(rank_or_symbol)[:rank]
      @file = to_rankfile(rank_or_symbol)[:file]
      @symbol = rank_or_symbol
    end
  end

  def translate(rankfile) 
    Square.new(@rank + rankfile[:rank], @file + rankfile[:file])
  end
end