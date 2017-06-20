class Square
  attr_reader :color, :piece

  INT_LOOKUP = {
    pawn: 1,
    knight: 2,
    bishop: 3,
    rook: 4,
    queen: 5,
    king: 6
  }

  SYM_LOOKUP = {
    pawn: 'p',
    knight: 'n',
    bishop: 'b',
    rook: 'r',
    queen: 'q',
    king: 'k'  
  }

  PIECE_LOOKUP = {
    em: {color: nil, piece: nil},
    wp: {color: :white, piece: :pawn},
    wn: {color: :white, piece: :knight},
    wb: {color: :white, piece: :bishop},
    wr: {color: :white, piece: :rook},
    wq: {color: :white, piece: :queen},
    wk: {color: :white, piece: :king},
    bp: {color: :black, piece: :pawn},
    bn: {color: :black, piece: :knight},
    bb: {color: :black, piece: :bishop},
    br: {color: :black, piece: :rook},
    bq: {color: :black, piece: :queen},
    bk: {color: :black, piece: :king},
  }

  def initialize(piece)
    if PIECE_LOOKUP[piece].nil?
      raise ArgumentError.new "invalid piece type #{piece.to_s}"
    end
    @empty = piece == :em
    @color =  PIECE_LOOKUP[piece][:color]
    @piece = PIECE_LOOKUP[piece][:piece]
  end

  def empty?
    @empty
  end

  def piece_is?(array)
    array.include?(self.piece)
  end

  def to_i
    if self.empty? 
      0
    else
      self.color == :black ? 0 - INT_LOOKUP[self.piece] : INT_LOOKUP[self.piece]
    end
  end

  def to_s
    if self.empty?
      "Empty"
    else
      "#{@color.to_s.capitalize} #{@piece.to_s.capitalize}"
    end
  end

  def to_sym
    if self.empty?
      :em
    else
      if self.color == :black 
        ('b' + SYM_LOOKUP[self.piece]).to_sym
      else
        ('w' + SYM_LOOKUP[self.piece]).to_sym
      end
    end
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
end