class BoardSquares

  BLANK = ('a'..'h').each_with_object({}) do |letter, o|
    (1..8).to_a.each { |number| o[(letter + number.to_s).to_sym] = Square.new(:empty) }
  end

  def initialize(data = BLANK)
    @data = data
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
    unless value.is_a? Square || value.zero
      raise ArgumentError.new "invalid value #{value} for BoardSquares. Must be of class Square"
    end
  end

  def validate_square(square)
    unless ('a'..'h').to_a.include?(square.to_s[0]) && (1..8).to_a.include?(square.to_s[1].to_i)
      raise ArgumentError.new "invalid square #{square.to_s}"
    end
  end

  def to_square(rank, file)
    ((rank + 96).chr + (file).to_s).to_sym
  end
end