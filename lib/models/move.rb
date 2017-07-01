class Move < Chess
  attr_reader :start, :finish, :promotion, :capture

  include Comparable

  def initialize(start, finish, promotion = false, capture = false)
    @start = start.is_a?(Square) ? start : Square.new(start)
    @finish = finish.is_a?(Square) ? finish : Square.new(finish)
    @promotion = promotion
    @capture = capture
    # if MODEL_VALIDATIONS
    #   validate_squares
    #   validate_promotion
    #   validate_capture
    # end
  end

  def <=>(other)
    [@start.symbol, @finish.symbol, @promotion, @capture] <=> [other.start.symbol, other.finish.symbol, other.promotion, other.capture]
  end

  def to_s
    if @promotion
      "#{@start.symbol} to #{@finish.symbol} P = #{@promotion}"
    elsif @capture
      "#{@start.symbol} captures on #{@finish.symbol}"
    else
      "#{@start.symbol} to #{@finish.symbol}"
    end
  end

  private

  def validate_squares
    unless ('a'..'h').to_a.include?(self.start.to_s[0]) && (1..8).to_a.include?(self.start.to_s[1].to_i) && self.start.is_a?(Symbol)
      raise ArgumentError.new "invalid start square #{self.start.to_s}"
    end
    unless ('a'..'h').to_a.include?(self.finish.to_s[0]) && (1..8).to_a.include?(self.finish.to_s[1].to_i) && self.finish.is_a?(Symbol)
      raise ArgumentError.new "invalid end square #{self.finish.to_s}"
    end
  end

  def validate_promotion
    unless [:knight, :bishop, :rook, :queen, false].include?(self.promotion)
      raise ArgumentError.new "invalid promotion #{self.promotion}"
    end
  end

  def validate_capture
    raise ArgumentError.new "invalid capture #{self.capture}" unless [true, false].include?(self.capture)
  end
end