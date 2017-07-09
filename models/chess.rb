class Chess
  def to_square(rank, file)
    ((file + 96).chr + (rank).to_s).to_sym
  end

  def to_rankfile(symbol)
    { rank: symbol.to_s[1].to_i, file: symbol.to_s[0].ord - 96 }
  end
end