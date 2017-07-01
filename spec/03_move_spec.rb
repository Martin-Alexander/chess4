require_relative '../lib/app'

describe "move", :move do
  context "initialization" do
    let(:square_one) { Square.new(:a1) }
    let(:square_two) { Square.new(3, 3) }

    it "should accept 4 arguments (last two optional): start square, end square, promotion, and capture" do
      expect { (Move.new(square_one, square_two, false, false)) }.not_to raise_error
      expect { (Move.new(square_one, square_two)) }.not_to raise_error
    end

    it "should default promotion and capture to false when not specified" do
      move = Move.new(square_one, square_two)
      expect(move.promotion).to be false
      expect(move.capture).to be false

      move_two = Move.new(square_one, square_two, true, true)
      expect(move_two.promotion).to be true
      expect(move_two.capture).to be true
    end

    it "should requre that start square and end square be Sqaure objects" do
      expect { Move.new(square_one, square_two) }.not_to raise_error
      expect { (Move.new(:a1, :a2, false, false)) }.to raise_error ArgumentError
      expect { (Move.new("a1", "a2", false, false)) }.to raise_error ArgumentError
    end

    it "should require that start square and end square be valid squares" do
      expect { (Move.new(:a1, :a2, false, false)) }.not_to raise_error
      expect { (Move.new(:a9, :a2, false, false)) }.to raise_error ArgumentError 
      expect { (Move.new(:i1, :a2, false, false)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a0, false, false)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :k2, false, false)) }.to raise_error ArgumentError
    end

    it "should requre that promotion be false or a valid piece" do
      expect { (Move.new(:a1, :a2, false, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, :knight, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, :bishop, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, :rook, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, :queen, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, :king, false)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, :pawn, false)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, true, false)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, 0, false)) }.to raise_error ArgumentError
    end

    it "should requre that capture be a boolean" do
      expect { (Move.new(:a1, :a2, false, false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, false, true)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, false, 0)) }.to raise_error ArgumentError
    end
  end

  context "comparison" do
    it "should compare Moves based on their start square, finish square, promotion, and capture" do
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2)).to be true
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a3)).to be false
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2, true, false)).to be false
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2, true, true)).to be false
    end
  end
end