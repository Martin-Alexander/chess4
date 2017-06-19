require_relative '../lib/app'

describe "board", :board do
  class BoardSquares
    attr_accessor :data
  end

  context "initialization" do
    it "should initialize to empty board by default" do
      board = BoardSquares.new
      board.data.values.each do |square| 
        expect(square.empty?).to be true
      end
    end
  end

  context "'[]' method" do
    let(:board) { BoardSquares.new }
    it "should allow reading" do
      board.data[:a1] = Square.new(:black, :king)
      expect(board[1, 1]).to be_instance_of(Square)
    end

    it "should allow writting" do
      board[1, 1] = Square.new(:black, :king)
      expect(board.data[:a1]).to be_instance_of(Square)
    end

    it "should raise an error when out of bounds" do
      expect { board[0, 1] }.to raise_error ArgumentError, "invalid rank:0 or file:1"
      expect { board[1, 0] }.to raise_error ArgumentError, "invalid rank:1 or file:0"
      expect { board[1, 9] }.to raise_error ArgumentError, "invalid rank:1 or file:9"
      expect { board[9, 1] }.to raise_error ArgumentError, "invalid rank:9 or file:1"
      expect { board[0, 1] = Square.new(:empty) }.to raise_error ArgumentError, "invalid rank:0 or file:1"
      expect { board[1, 0] = Square.new(:empty) }.to raise_error ArgumentError, "invalid rank:1 or file:0"
      expect { board[1, 9] = Square.new(:empty) }.to raise_error ArgumentError, "invalid rank:1 or file:9"
      expect { board[9, 1] = Square.new(:empty) }.to raise_error ArgumentError, "invalid rank:9 or file:1"
    end

    it "should raise an error when invalid piece" do
      expect { board[1, 1] =  1 }.to raise_error ArgumentError, "invalid value 1 for BoardSquares. Must be of class Square"
    end
  end

  context "'square' method" do
    let(:board) { BoardSquares.new }
    it "should allow reading" do
      board.data[:a1] = Square.new(:black, :king)
      expect(board.square(:a1)).to be_instance_of(Square)
    end

    it "should allow writting" do
      board.square(:a1, Square.new(:black, :king))
      expect(board.data[:a1]).to be_instance_of(Square)
    end

    it "should raise an error when invalid square" do
      expect { board.square(:i1) }.to raise_error ArgumentError, "invalid square i1"
      expect { board.square(:a0) }.to raise_error ArgumentError, "invalid square a0"
      expect { board.square(:a9) }.to raise_error ArgumentError, "invalid square a9"
    end

    it "should raise an error when invalid piece" do
      expect { board.square(:a1, 1) }.to raise_error ArgumentError, "invalid value 1 for BoardSquares. Must be of class Square"
    end
  end
end