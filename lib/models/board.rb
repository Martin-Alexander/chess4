class BoardSquares
  def initialize
    @data = {
      a8: 0, b8: 0, c8: 0, d8: 0, e8: 0, f8: 0, g8: 0, h8: 0,   
      a7: 0, b7: 0, c7: 0, d7: 0, e7: 0, f7: 0, g7: 0, h7: 0,
      a6: 0, b6: 0, c6: 0, d6: 0, e6: 0, f6: 0, g6: 0, h6: 0,
      a5: 0, b5: 0, c5: 0, d5: 0, e5: 0, f5: 0, g5: 0, h5: 0,
      a4: 0, b4: 0, c4: 0, d4: 0, e4: 0, f4: 0, g4: 0, h4: 0,
      a3: 0, b3: 0, c3: 0, d3: 0, e3: 0, f3: 0, g3: 0, h3: 0,
      a2: 0, b2: 0, c2: 0, d2: 0, e2: 0, f2: 0, g2: 0, h2: 0,
      a1: 0, b1: 0, c1: 0, d1: 0, e1: 0, f1: 0, g1: 0, h1: 0
    }
  end

  def [](rank, file)
    validate_rank_file(rank, file) 
    data_array[rank - 1][file - 1]
  end

  def []=(rank, file, value)
    validate_rank_file(rank, file)
    validate_value(value)
    @data[to_square(rank, file)] = value
  end

  def square(key, value = nil)
    validate_square(key)
    if value.nil?
      @data[key].dup
    else
      validate_value(value)
      @data[key] = value
    end
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

  def validate_rank_file(rank, file)
    if rank > 8 || rank < 1 || file > 8 || file < 1
      raise ArgumentError.new "invalid rank:#{rank} or file:#{file}"
    else
      true
    end
  end

  def validate_value(value)
    unless value.is_a? Piece || value.zero
      raise ArgumentError.new "invalid value #{value} for BoardSquares. Must be 0 or of class Piece"
    end
  end

  def validate_square(square)
    unless ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].include?(square.to_s[0]) && (1..8).to_a.include?(square.to_s[1].to_i)
      raise ArgumentError.new "invalid square #{square.to_s}"
    end
  end

  def to_square(rank, file)
    ((rank + 96).chr + (file).to_s).to_sym
  end
end