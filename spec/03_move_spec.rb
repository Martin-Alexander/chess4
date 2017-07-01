require_relative '../lib/app'

describe "move", :move do
  context "initialization" do
    let(:square_one) { Square.new(:a1) }
    let(:square_two) { Square.new(3, 3) }

    it "should accept 4 arguments (last two optional): start square, end square, promotion, and capture" do
      expect { (Move.new(square_one, square_two)) }.not_to raise_error
      expect { (Move.new(square_one, square_two)) }.not_to raise_error
    end

    it "should default promotion and capture to false when not specified" do
      move = Move.new(square_one, square_two)
      expect(move.promotion).to be false
      expect(move.capture).to be false

      move_two = Move.new(square_one, square_two, promotion: :queen, capture: true)
      expect(move_two.promotion).to be :queen
      expect(move_two.capture).to be true
    end

    it "should require that start square and end square be Sqaure objects or valid symbols" do
      expect { Move.new(square_one, square_two) }.not_to raise_error
      expect { (Move.new(:a1, :a2)) }.not_to raise_error
      expect { (Move.new("a1", "a2")) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a0)) }.to raise_error ArgumentError
      expect { (Move.new(:a9, :a1)) }.to raise_error ArgumentError
      expect { (Move.new(:i2, :a1)) }.to raise_error ArgumentError
    end


    it "should require that promotion be false or a valid piece" do
      expect { (Move.new(:a1, :a2)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, promotion: :knight)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, promotion: :bishop)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, promotion: :rook)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, promotion: :queen)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, promotion: :king)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, promotion: :pawn)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, promotion: true)) }.to raise_error ArgumentError
      expect { (Move.new(:a1, :a2, promotion: 0)) }.to raise_error ArgumentError
    end

    it "should require that capture be a boolean" do
      expect { (Move.new(:a1, :a2, capture: false)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, capture: true)) }.not_to raise_error
      expect { (Move.new(:a1, :a2, capture: 0)) }.to raise_error ArgumentError
    end
  end

  context "comparison" do
    it "should compare Moves based on their start square, finish square, promotion, and capture" do
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2)).to be true
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a3)).to be false
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2, promotion: :queen)).to be false
      expect(Move.new(:a1, :a2) == Move.new(:a1, :a2, promotion: :knight, capture: true)).to be false
    end
  end
end