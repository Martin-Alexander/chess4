require_relative '../lib/app'

describe "square", :square do
  context "initialization" do
    it "should require a piece and color unless it's empty" do
      expect { Square.new }.to raise_error ArgumentError, "wrong number of arguments (given 0, expected 1)"
    end

    it "should contain a piece type unless empty" do
      square = Square.new(:bk)
      expect(square.piece).to eq(:king)
      empty_square = Square.new(:em)
      expect(empty_square.piece).to be_nil
    end

    it "should contain a color unless empty" do
      square = Square.new(:bk)
      expect(square.color).to eq(:black)
      empty_square = Square.new(:em)
      expect(empty_square.color).to be_nil      
    end

    it "should only accept valid piece types" do
      expect { Square.new(:bi) }.to raise_error ArgumentError, "invalid piece type bi"
    end
  end

  context "identity methods" do
    pieces = ["pawn", "knight", "bishop", "rook", "queen", "king"]
    piece_symbols = [:bp, :wn, :bb, :wr, :bq, :wk]
    for i in (0...5)
      it "'is_#{pieces[i]}?' should determine if piece is a #{pieces[i]}" do
        square = Square.new(piece_symbols[i])
        expect(square.send("is_#{pieces[i]}?".to_sym)).to be true
        square = Square.new(piece_symbols[i - 1])
        expect(square.send("is_#{pieces[i]}?".to_sym)).to be false
      end
    end

    it "'empty? should determine if square is empty" do
      empty_square = Square.new(:em)
      expect(empty_square.empty?).to be true
      normail_square = Square.new(:wk)
      expect(normail_square.empty?).to be false
    end

    it "'piece_is?' should determine if square type is included in array" do
      square = Square.new(:bk)
      expect(square.piece_is? [:king, :bishop, :rook]).to be true
      expect(square.piece_is? [:king]).to be true
      expect(square.piece_is? [:pawn, :queen, :knight]).to be false
    end
  end

  context "converters" do
    it "to_i should return appropriate integer" do
      expect(Square.new(:bk).to_i).to eq(-6)
      expect(Square.new(:wp).to_i).to eq(1)
      expect(Square.new(:em).to_i).to eq(0)
    end

    it "to_s should return appropriate string" do
      expect(Square.new(:br).to_s).to eq("Black Rook")
      expect(Square.new(:wk).to_s).to eq("White King")
      expect(Square.new(:em).to_s).to eq("Empty")
    end

    it "to_sym should return appropriate symbol" do 
      expect(Square.new(:wb).to_sym).to eq(:wb)
      expect(Square.new(:bq).to_sym).to eq(:bq)
      expect(Square.new(:em).to_sym).to eq(:em)
    end
  end
end