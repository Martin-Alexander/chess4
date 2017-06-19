class Square
  attr_reader :color, :piece

  def initialize(type, piece = nil)
    if type.to_sym == :empty
      raise ArgumentError.new "empty squares cannot contain other attributes" unless piece.nil?
      @color = nil
      @piece = nil
      @empty = true
    else
      @empty = false
      @color = type.to_sym
      validate_color
      @piece = piece.to_sym
      validate_piece
    end
  end

  def empty?
    @empty
  end

  def piece_is?(array)
    array.include?(self.piece)
  end

  def is_pawn?
    self.piece == :pawn
  end

  def is_knight?
    self.piece == :knight
  end

  def is_bishop?
    self.piece == :bishop
  end

  def is_rook?
    self.piece == :rook
  end

  def is_queen?
    self.piece == :queen
  end

  def is_king?
    self.piece == :king
  end

  def to_s
    if self.empty?
      "Empty"
    else
      "#{@color.to_s.capitalize} #{@piece.to_s.capitalize}"
    end
  end

  private

  def validate_color
    unless [:black, :white].include?(self.color)
      raise ArgumentError.new "invalid color #{self.color}"
    end
  end

  def validate_piece
    unless piece_is? [:pawn, :knight, :bishop, :rook, :queen, :king]
      raise ArgumentError.new "invalid piece type #{self.piece}"
    end
  end
end