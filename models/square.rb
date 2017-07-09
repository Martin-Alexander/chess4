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
    if other.is_a?(Square)
      @symbol == other.symbol
    elsif other.is_a?(Symbol)
      @symbol == other
    else
      raise ArgumentError.new "invalid comperator #{other.class}"
    end
  end

  def validate_rankfile(rankfile)
    unless rankfile.is_a? Integer
      raise ArgumentError.new "rankfile must be of type Integer. Was #{rankfile.class}"
    end
    unless rankfile < 9 
      raise ArgumentError.new "invalid rankfile. Rank: #{self.rank}, file: #{self.file}"
    end
    unless rankfile > 0
      raise ArgumentError.new "invalid rankfile. Rank: #{self.rank}, file: #{self.file}"
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