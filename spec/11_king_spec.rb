require_relative '../lib/app'

describe "king", :king do 
  white_board = Board.new([
    :em, :em, :em, :em, :em, :em, :em, :wk,
    :em, :em, :em, :em, :em, :em, :em, :em,
    :em, :em, :bp, :wp, :wp, :em, :em, :em, 
    :em, :em, :bp, :wk, :bp, :em, :em, :em, 
    :em, :em, :wp, :wp, :bp, :em, :em, :em,
    :em, :em, :em, :em, :em, :em, :em, :em, 
    :em, :wk, :em, :em, :em, :em, :em, :em, 
    :em, :em, :em, :em, :em, :em, :em, :em,
  ])

  white_game = GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)

  let(:white_legal_moves) { LegalMoves.new(white_game).legal_moves }
  let(:white_moves) { [
    Move.new(:b2, :a1),
    Move.new(:b2, :a2),
    Move.new(:b2, :a3),
    Move.new(:b2, :b1),
    Move.new(:b2, :b3),
    Move.new(:b2, :c1),
    Move.new(:b2, :c2),
    Move.new(:b2, :c3),
    Move.new(:d5, :c5, capture: true),
    Move.new(:d5, :c6, capture: true),
    Move.new(:d5, :e4, capture: true),
    Move.new(:d5, :e5, capture: true),
    Move.new(:h8, :g8),
    Move.new(:h8, :g7),
    Move.new(:h8, :h7),
    Move.new(:d6, :d7),
    Move.new(:e6, :e7),
    Move.new(:d4, :e5, capture: true),
    Move.new(:d4, :c5, capture: true)
  ] }

  it "should generate all appropriate moves" do
    white_moves.each do |move|
      expect(white_legal_moves.include?(move)).to be true
    end
  end
end