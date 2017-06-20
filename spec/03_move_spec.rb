require_relative '../lib/app'

describe "move", :move do
  context "initialization" do
    it "should accept 4 arguments: start square, end square, promotion, and capture" do
      expect { (Move.new(:a2, :a4, false, false)) }.not_to raise_error
    end

    it "should requre that start square and end square be symbols" do
      expect { (Move.new(:a1, :a2, false, false)) }.not_to raise_error
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
end