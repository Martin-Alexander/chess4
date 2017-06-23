class GameState
  attr_reader :board, :castling, :en_passant, :white_to_move

  def initialize(board, castling, en_passant, white_to_move)
    if MODEL_VALIDATIONS
      validate_board(board)
      validate_castling(castling)
      validate_en_passant(en_passant)
      validate_white_to_move(white_to_move)
    end
    @board = board
    @castling = castling
    @en_passant = en_passant
    @white_to_move = white_to_move
  end

  private

  def validate_board(board)
    unless board.is_a?(Board)
      raise ArgumentError.new "invalid board #{board}:#{board.class}. Must be of type Board"
    end
  end

  def validate_castling(hash)
    unless hash.values.length == 4 &&
      hash.keys.all? { |key| [:wk, :bk, :wq, :bq].include?(key) } &&
      hash.values.all? { |value| value == true || value == false }
      raise ArgumentError.new "invalid castling hash"
    end
  end

  def validate_en_passant(square)
    unless validate_square(square)
      raise ArgumentError.new "invalid en passant square"
    end
  end

  def validate_white_to_move(white_to_move)
    unless white_to_move == true || white_to_move == false
      raise ArgumentError.new "invalid white to move"
    end
  end

  def validate_square(square)
    ('a'..'h').to_a.include?(square.to_s[0]) && (1..8).to_a.include?(square.to_s[1].to_i)
  end
end