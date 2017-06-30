class Move < Chess
  attr_reader :start, :finish, :promotion, :capture

  def initialize(start, finish, promotion = false, capture = false)
    @start = start
    @finish = finish
    @promotion = promotion
    @capture = capture
    # if MODEL_VALIDATIONS
    #   validate_squares
    #   validate_promotion
    #   validate_capture
    # end
  end

  def to_d

  

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