require_relative '../app/app'

describe "piece", :piece do
  context "initialization" do
    it "should require a piece and color unless it's empty" do
      expect { Piece.new }.to raise_error ArgumentError, "wrong number of arguments (given 0, expected 1)"
    end

    it "should contain a piece type unless empty" do
      square = Piece.new(:bk)
      expect(square.piece).to eq(:king)
      empty_square = Piece.new(:em)
      expect(empty_square.piece).to be_nil
    end

    it "should contain a color unless empty" do
      square = Piece.new(:bk)
      expect(square.color).to eq(:black)
      empty_square = Piece.new(:em)
      expect(empty_square.color).to be_nil      
    end

    it "should only accept valid piece types" do
      expect { Piece.new(:bi) }.to raise_error ArgumentError, "invalid piece type bi"
    end
  end

  context "identity methods" do
    pieces = ["pawn", "knight", "bishop", "rook", "queen", "king"]
    piece_symbols = [:bp, :wn, :bb, :wr, :bq, :wk]
    for i in (0...5)
      it "'is_#{pieces[i]}?' should determine if piece is a #{pieces[i]}" do
        square = Piece.new(piece_symbols[i])
        expect(square.send("is_#{pieces[i]}?".to_sym)).to be true
        square = Piece.new(piece_symbols[i - 1])
        expect(square.send("is_#{pieces[i]}?".to_sym)).to be false
      end
    end

    it "'empty? should determine if square is empty" do
      empty_square = Piece.new(:em)
      expect(empty_square.empty?).to be true
      normail_square = Piece.new(:wk)
      expect(normail_square.empty?).to be false
    end

    it "'piece_is?' should determine if square type is included in array" do
      square = Piece.new(:bk)
      expect(square.piece_is? [:king, :bishop, :rook]).to be true
      expect(square.piece_is? [:king]).to be true
      expect(square.piece_is? [:pawn, :queen, :knight]).to be false
    end
  end

  context "converters" do
    it "to_i should return appropriate integer" do
      expect(Piece.new(:bk).to_i).to eq(-6)
      expect(Piece.new(:wp).to_i).to eq(1)
      expect(Piece.new(:em).to_i).to eq(0)
    end

    it "to_s should return appropriate string" do
      expect(Piece.new(:br).to_s).to eq("Black Rook")
      expect(Piece.new(:wk).to_s).to eq("White King")
      expect(Piece.new(:em).to_s).to eq("Empty")
    end

    it "to_sym should return appropriate symbol" do 
      expect(Piece.new(:wb).to_sym).to eq(:wb)
      expect(Piece.new(:bq).to_sym).to eq(:bq)
      expect(Piece.new(:em).to_sym).to eq(:em)
    end
  end
end