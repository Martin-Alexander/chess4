require_relative '../lib/app'

describe "knight", :knight do 
  white_board = Board.new([
    :em, :em, :em, :em, :em, :em, :em, :wn,
    :em, :em, :em, :em, :em, :em, :em, :em,
    :bp, :em, :bp, :em, :em, :em, :em, :em, 
    :em, :em, :em, :bp, :em, :em, :em, :em, 
    :em, :wn, :em, :em, :em, :em, :wp, :em,
    :em, :em, :em, :bp, :em, :bp, :em, :em, 
    :bp, :em, :bp, :em, :em, :em, :em, :wn, 
    :em, :em, :em, :em, :em, :bp, :em, :em
  ])

  white_game = GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)

  let(:white_legal_moves) { LegalMoves.new(white_game).legal_moves }
  let(:white_moves) { [
  	Move.new(:b4, :a6, capture: true),
  	Move.new(:b4, :c6, capture: true),
  	Move.new(:b4, :d5, capture: true),
  	Move.new(:b4, :d3, capture: true),
  	Move.new(:b4, :c2, capture: true),
  	Move.new(:b4, :a2, capture: true),
  	Move.new(:h2, :f3, capture: true),
  	Move.new(:h2, :f1, capture: true),
  	Move.new(:g4, :g5),
  	Move.new(:h8, :f7),
  	Move.new(:h8, :g6)
  ] }

  it "should generate all appropriate moves" do
    white_moves.each do |move|
      expect(white_legal_moves.include?(move)).to be true
    end
  end
end