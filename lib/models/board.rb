class Board < Chess
  def initialize(data = standard_board)
    if data == :empty
      empty_array = []
      64.times { empty_array << :em }
      @data = load_data(empty_array)
    else
      if MODEL_VALIDATIONS
        raise ArgumentError.new "board data must be of type Array" unless data.is_a?(Array)
        raise ArgumentError.new "invalid length #{data.length} for board data" unless data.length == 64
        data.each do |value|
          validate_value(Piece.new(value))
        end
      end
      @data = load_data(data)
    end
  end

  def [](x, y = false)
    if x.is_a?(Symbol) && y == false
      validate_square(x)
      @data[x]
    else x.is_a?(Integer) && y.is_a?(Integer)
      validate_rank_file(x, y) 
      data_array[x - 1][y - 1]
    end
  end

  def []=(x, y = false, z)
    if x.is_a?(Symbol) && y == false
      validate_square(x)
      validate_value(z)
      @data[x] = z
    else 
      validate_rank_file(x, y)
      validate_value(z)
      @data[to_square(x, y)] = z
    end
  end

  def to_s
    puts "_______________________"
    data_array.reverse.each do |row|
      row.each do |square| 
        if square.empty?
          print "-- "
        else 
          print "#{square.to_sym} "
        end
      end
      puts
    end
    puts 
  end

  private

  def data_array
    output = []
    @data.values.each_with_index do |e, i|
      output << [] if i % 8 == 0 
      output[-1] << e
    end
    output.reverse
  end

  def load_data(pieces)
    squares = list_of_squares_symbols
    (0..63).each_with_object({}) do |i, obj|
      obj[squares[i]] = Piece.new(pieces[i])
    end
  end

  def list_of_squares_symbols
    [8, 7, 6, 5, 4, 3, 2, 1].each_with_object([]) do |number, obj|
      ('a'..'h').each { |letter| obj << (letter + number.to_s).to_sym }
    end
  end

  def validate_rank_file(rank, file)
    if MODEL_VALIDATIONS
      if rank > 8 || rank < 1 || file > 8 || file < 1 && rank.is_a?(Integer) && file.is_a?(Integer)
        raise ArgumentError.new "invalid rank:#{rank} or file:#{file}"
      else
        true
      end
    end
  end

  def validate_value(value)
    if MODEL_VALIDATIONS
      unless value.is_a? Piece
        raise ArgumentError.new "invalid value #{value} for Board. Must be of class Piece"
      end
    end
  end

  def validate_square(square)
    if MODEL_VALIDATIONS
      unless ('a'..'h').to_a.include?(square.to_s[0]) && (1..8).to_a.include?(square.to_s[1].to_i)
        raise ArgumentError.new "invalid square #{square.to_s}"
      end
    end
  end

  def standard_board 
    [
      :br, :bn, :bb, :bq, :bk, :bb, :bn, :br,
      :bp, :bp, :bp, :bp, :bp, :bp, :bp, :bp,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :wp, :wp, :wp, :wp, :wp, :wp, :wp, :wp, 
      :wr, :wn, :wb, :wq, :wk, :wb, :wn, :wr
    ]
  end

  def print_square(square)
    if square.to_i > 0
      " #{square.to_i}"
    else
      "#{square.to_i}"
    end
  end
end