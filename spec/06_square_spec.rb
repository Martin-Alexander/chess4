require_relative '../lib/app'

describe "square" do
  context "initialization" do
    it "should initialize with symbol" do
      expect(Square.new(:a1).rank).to eq(1)
      expect(Square.new(:a1).file).to eq(1)

      expect(Square.new(:e2).rank).to eq(2)
      expect(Square.new(:e2).file).to eq(5)
    end

    it "should initialize with rankfile" do
      expect(Square.new(1, 1).rank).to eq(1)
      expect(Square.new(1, 1).file).to eq(1)

      expect(Square.new(2, 5).rank).to eq(2)
      expect(Square.new(2, 5).file).to eq(5)
    end
  end
end