class Square < Chess
  attr_reader :rank, :file, :symbol

  include Comparable 

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
    if MODEL_VALIDATIONS
      validate_rankfile(@rank)
      validate_rankfile(@file)
      validate_symbol
    end
  end

  def to_s
    @symbol.to_s
  end

  def <=>(other)
    @symbol == other.symbol
  end

  def validate_rankfile(rankfile)
    unless rankfile < 9 && rankfile > 0
      raise ArgumentError.new "invalid start square #{self.symbol.to_s}"
    end
  end

  def validate_symbol
    unless ('a'..'h').to_a.include?(self.symbol.to_s[0]) && (1..8).to_a.include?(self.symbol.to_s[1].to_i) && self.symbol.is_a?(Symbol)
      raise ArgumentError.new "invalid square #{self.symbol.to_s}"
    end
  end

  def translate(rankfile) 
    Square.new(@rank + rankfile[:rank], @file + rankfile[:file])
  end
end