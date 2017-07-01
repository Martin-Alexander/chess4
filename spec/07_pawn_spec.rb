require_relative '../lib/app'

describe "pawn", :pawn do

  context "movement" do
    let(:white_board) { Board.new([
      :em, :em, :em, :em, :wp, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :wp, :em, :em, :em, :em,
      :em, :wp, :wp, :wp, :em, :em, :em, :em, 
      :wp, :em, :wp, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em
    ]) }
    let(:white_game) {
      GameState.new(white_board, { wk: true, wq: true, bk: true, bq: true }, :a1, true)
    }
    let(:white_legal_moves) { LegalMoves.new(white_game).legal_moves }
    let(:white_single_advance) { [Move.new(:a2, :a3), Move.new(:b3, :b4), Move.new(:c3, :c4), Move.new(:d4, :d5)] }
    let(:white_double_advance) { [Move.new(:a2, :a4)] }

    let(:black_board) { Board.new([
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :bp, :em, :bp,
      :em, :em, :em, :em, :bp, :bp, :bp, :em, 
      :em, :em, :em, :em, :bp, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :bp, :em, :em, :em, :em
    ]) }
    let(:black_game) {
      GameState.new(black_board, { wk: true, wq: true, bk: true, bq: true }, :a1, false)
    }
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

    it "overall movement" do
      expect(white_legal_moves.sort == [white_single_advance + white_double_advance].flatten.sort).to be true
      expect(black_legal_moves.sort == [black_single_advance + black_double_advance].flatten.sort).to be true
    end

  end

  context "capture" do
  end

  context "promotion" do
  end

  context "en passent" do
  end
end