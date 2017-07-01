require_relative '../lib/app'

describe "pawn", :pawn do

  context "movement" do
    white_board = Board.new([
      :em, :em, :em, :em, :wp, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :wp, :em, :em, :em, :em,
      :em, :wp, :wp, :wp, :em, :em, :em, :em, 
      :wp, :em, :wp, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em
    ])

    white_game = GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)

    let(:white_legal_moves) { LegalMoves.new(white_game).legal_moves }
    let(:white_single_advance) { [Move.new(:a2, :a3), Move.new(:b3, :b4), Move.new(:c3, :c4), Move.new(:d4, :d5)] }
    let(:white_double_advance) { [Move.new(:a2, :a4)] }

    black_board = Board.new([
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :bp, :em, :bp,
      :em, :em, :em, :em, :bp, :bp, :bp, :em, 
      :em, :em, :em, :em, :bp, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :bp, :em, :em, :em, :em
    ])
    
    black_game = GameState.new(black_board, { wk: true, wq: true, bk: true, bq: true }, :a1, false)

    let(:black_legal_moves) { LegalMoves.new(black_game).legal_moves }
    let(:black_single_advance) { [Move.new(:h7, :h6), Move.new(:g6, :g5), Move.new(:f6, :f5), Move.new(:e5, :e4)] }
    let(:black_double_advance) { [Move.new(:h7, :h5)] }

    it "single advance" do
      white_single_advance.each do |move|
        expect(white_legal_moves.include?(move)).to be true
      end

      black_single_advance.each do |move|
        expect(black_legal_moves.include?(move)).to be true
      end
    end

    it "double advance" do
      white_double_advance.each do |move|
        expect(white_legal_moves.include?(move)).to be true
      end      
      black_double_advance.each do |move|
        expect(black_legal_moves.include?(move)).to be true
      end          
    end

    it "overall" do
      expect(white_legal_moves.sort == [white_single_advance + white_double_advance].flatten.sort).to be true
      expect(black_legal_moves.sort == [black_single_advance + black_double_advance].flatten.sort).to be true
    end

  end

  context "capture" do
    white_board = Board.new([
        :em, :em, :em, :em, :em, :em, :bp, :em,
        :em, :em, :em, :em, :em, :em, :em, :wp,
        :em, :em, :em, :em, :em, :em, :em, :em,
        :em, :em, :em, :em, :em, :em, :em, :em,
        :em, :em, :bp, :em, :bp, :em, :em, :em,
        :em, :bp, :em, :wp, :em, :em, :em, :em,
        :wp, :em, :em, :em, :em, :em, :em, :em,
        :em, :em, :em, :em, :em, :em, :em, :em 
    ])

    white_game = GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)

    let(:white_legal_moves) { LegalMoves.new(white_game).legal_moves }
    let(:white_capture) { [Move.new(:a2, :b3, capture: true), Move.new(:d3, :c4, capture: true), Move.new(:d3, :e4, capture: true), Move.new(:h7, :g8, capture: true)] }
    let(:white_non_capture) { [Move.new(:a2, :a3), Move.new(:a2, :a4), Move.new(:d3, :d4), Move.new(:h7, :h8)] }

    black_board = Board.new([
        :em, :em, :em, :em, :em, :em, :em, :em,
        :em, :em, :em, :em, :em, :em, :em, :bp,
        :em, :em, :em, :em, :bp, :em, :wp, :em,
        :em, :em, :em, :wp, :em, :wp, :em, :em,
        :em, :em, :em, :em, :em, :em, :em, :em,
        :em, :em, :em, :em, :em, :em, :em, :em,
        :bp, :em, :em, :em, :em, :em, :em, :em,
        :em, :wp, :em, :em, :em, :em, :em, :em 
    ])

    black_game = GameState.new(black_board, { wk: true, wq: true, bk: true, bq: true }, :a1, false)

    let(:black_legal_moves) { LegalMoves.new(black_game).legal_moves }
    let(:black_capture) { [Move.new(:a2, :b1, capture: true), Move.new(:e6, :d5, capture: true), Move.new(:e6, :f5, capture: true), Move.new(:h7, :g6, capture: true)] }
    let(:black_non_capture) { [Move.new(:a2, :a1), Move.new(:h7, :h5), Move.new(:e6, :e5), Move.new(:h7, :h6)] }

    it "diagonal capture" do
      white_capture.each do |move|
        expect(white_legal_moves.include?(move)).to be true
      end
      black_capture.each do |move|
        expect(black_legal_moves.include?(move)).to be true
      end      
    end

    it "overall" do
      expect(white_legal_moves.sort == [white_capture + white_non_capture].flatten.sort).to be true
      expect(black_legal_moves.sort == [black_capture + black_non_capture].flatten.sort).to be true
    end
  end

  context "promotion" do
  end

  context "en passent" do
  end

  context "overall" do
  end
end