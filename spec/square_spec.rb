require_relative '../lib/app'

describe "square", :square do
  context "initialization" do
    it "should require a piece and color unless it's empty" do
      expect { Square.new }.to raise_error ArgumentError, "wrong number of arguments (given 0, expected 1..2)"
    end

    it "should contain a piece type unless empty" do
      square = Square.new(:black, :king)
      expect(square.piece).to eq(:king)
      empty_square = Square.new(:empty)
      expect(empty_square.piece).to be_nil
    end

    it "should contain a color unless empty" do
      square = Square.new(:black, :king)
      expect(square.color).to eq(:black)
      empty_square = Square.new(:empty)
      expect(empty_square.color).to be_nil      
    end

    it "should only accept valid piece types" do
      expect { Square.new(:black, :invalid_type_of_piece) }.to raise_error ArgumentError, "invalid piece type invalid_type_of_piece"
    end

    it "should only accept valid colors" do
      expect { Square.new(:invalid_color, :king) }.to raise_error ArgumentError, "invalid color invalid_color"
    end

    it "should only accept one argument if empty" do
      expect { Square.new(:empty, :king) }.to raise_error ArgumentError, "empty squares cannot contain other attributes"
    end
  end

  context "identity methods" do
    pieces = ["pawn", "knight", "bishop", "rook", "queen", "king"]
    pieces.each_with_index do |test_piece, i|
      it "'is_#{test_piece}?' should determine if piece is a #{test_piece}" do
        square = Square.new(:black, test_piece.to_sym)
        expect(square.send("is_#{test_piece}?".to_sym)).to be true
        square = Square.new(:black, pieces[i - 1].to_sym)
        expect(square.send("is_#{test_piece}?".to_sym)).to be false
      end
    end

    it "'empty? should determine if square is empty" do
      empty_square = Square.new(:empty)
      expect(empty_square.empty?).to be true
      normail_square = Square.new(:white, :king)
      expect(normail_square.empty?).to be false
    end

    it "'piece_is?' should determine if square type is included in array" do
      square = Square.new(:black, :king)
      expect(square.piece_is? [:king, :bishop, :rook]).to be true
      expect(square.piece_is? [:king]).to be true
      expect(square.piece_is? [:pawn, :queen, :knight]).to be false
    end
  end
end