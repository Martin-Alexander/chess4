require_relative '../app/app'

describe "bishop", :bishop do 
  white_board = Board.new([
    :em, :em, :em, :em, :bp, :em, :em, :em,
    :em, :em, :em, :bp, :em, :em, :em, :em,
    :em, :em, :em, :em, :em, :em, :em, :em, 
    :em, :wb, :em, :em, :em, :em, :em, :wb, 
    :bp, :em, :em, :em, :em, :em, :em, :em,
    :em, :em, :em, :em, :em, :em, :em, :em, 
    :em, :em, :em, :em, :wp, :em, :em, :em, 
    :em, :em, :em, :em, :em, :em, :em, :em,
  ])

  white_game = GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)

  let(:white_legal_moves) { GenerateMoves.new(white_game).legal_moves }
  let(:white_moves) { [
    Move.new(:b5, :a6),
    Move.new(:b5, :c6),
    Move.new(:b5, :d7, capture: true),
    Move.new(:b5, :c4),
    Move.new(:b5, :d3),
    Move.new(:b5, :a4, capture: true),
    Move.new(:h5, :g6),
    Move.new(:h5, :f7),
    Move.new(:h5, :e8, capture: true),
    Move.new(:h5, :g4),
    Move.new(:h5, :f3),
    Move.new(:e2, :e3),
    Move.new(:e2, :e4, double_advance: true)
   ] }

  it "should generate all appropriate moves" do
    white_moves.each do |move|
      expect(white_legal_moves.include?(move)).to be true
    end
  end
end