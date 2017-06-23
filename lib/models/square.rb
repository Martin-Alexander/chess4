class Square
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

  private

  def to_square(rank, file)
    ((file + 96).chr + (rank).to_s).to_sym
  end

  def to_rankfile(symbol)
    { rank: symbol.to_s[0].ord - 96, file: symbol.to_s[0].ord }
  end
end