require_relative '../lib/app'

describe "square", :square do
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

  context "translation" do
    let(:initial_square) { Square.new(:a1) }
    let(:translation_square) { initial_square.translate(rank: 1, file: 3) }

    it "should take in a rank and a file tranlation and return the appropriate square" do
      
      expect(translation_square.rank).to eq(2)
      expect(translation_square.file).to eq(4)
    end
  end
end