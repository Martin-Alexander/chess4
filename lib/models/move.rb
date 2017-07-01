class Move < Chess
  attr_reader :start, :finish, :promotion, :capture

  include Comparable

  def initialize(start, finish, sup = {})
    @start = start.is_a?(Square) ? start : Square.new(start)
    @finish = finish.is_a?(Square) ? finish : Square.new(finish)
    @promotion = sup[:promotion] || false
    @capture = sup[:capture] || false
    if MODEL_VALIDATIONS
      validate_promotion
      validate_capture
    end
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

  def self.new_pawn_move(start, finish, sup = {})
    if finish.rank == 1 || finish.rank == 8
      output = []
      [:knight, :bishop, :rook, :queen].each do |promotion|
        output << Move.new(start, finish, capture: sup[:capture], promotion: promotion)
      end
      return output
    else
      return Move.new(start, finish, capture: sup[:capture])
    end
  end

  private

  def validate_promotion
    unless [:knight, :bishop, :rook, :queen, false].include?(self.promotion)
      raise ArgumentError.new "invalid promotion #{self.promotion}"
    end
  end

  def validate_capture
    raise ArgumentError.new "invalid capture #{self.capture}" unless [true, false].include?(self.capture)
  end
end