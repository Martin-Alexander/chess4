require_relative '../lib/app'

describe "board", :board do
  class Board
    attr_accessor :data
  end

  context "initialization" do
    let(:standard_board) { [
      :br, :bn, :bb, :bq, :bk, :bb, :bn, :br,
      :bp, :bp, :bp, :bp, :bp, :bp, :bp, :bp,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :wp, :wp, :wp, :wp, :wp, :wp, :wp, :wp, 
      :wr, :wn, :wb, :wq, :wk, :wb, :wn, :wr
    ] }

    let(:test_board) { [
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :bk, :wp, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :wk, :em, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :em, :em,
      :em, :em, :em, :em, :em, :em, :em, :em, 
      :em, :em, :wk, :em, :em, :em, :em, :em, 
      :em, :em, :em, :em, :em, :em, :wr, :em
    ] }

    it "should initialize to standard board by default" do
      board = Board.new
      board.data.values.each_with_index do |square, i| 
        expect(square.to_sym).to be(standard_board[i])
      end
      expect(board[:a1].to_s).to eq("White Rook")
      expect(board[:h8].to_s).to eq("Black Rook")
    end

    it "should initialize to empty board when given ':empty'" do
      board = Board.new(:empty)
      board.data.values.each do |square|
        expect(square.empty?).to be true
      end
    end

    it "should initialize with array of symbols" do
      board = Board.new(test_board)
      expect(board.data.values.map{ |i| i.to_sym }).to eq(test_board)
    end

    it "should requre a 64-length array" do
      expect { Board.new(test_board) }.not_to raise_error
      test_board << :em
      expect { Board.new(test_board) }.to raise_error ArgumentError
    end

    it "should require array to contain valid squares" do
      expect { Board.new(test_board) }.not_to raise_error
      test_board[0] = :jk
      expect { Board.new(test_board) }.to raise_error ArgumentError
    end
  end

  context "'[]' method with rank and file" do
    let(:board) { Board.new }
    it "should allow reading" do
      board.data[:a1] = Piece.new(:bk)
      expect(board[1, 1]).to be_instance_of(Piece)
    end

    it "should allow writting" do
      board[1, 1] = Piece.new(:bk)
      expect(board.data[:a1]).to be_instance_of(Piece)
    end

    it "should raise an error when out of bounds" do
      expect { board[0, 1] }.to raise_error ArgumentError, "invalid rank:0 or file:1"
      expect { board[1, 0] }.to raise_error ArgumentError, "invalid rank:1 or file:0"
      expect { board[1, 9] }.to raise_error ArgumentError, "invalid rank:1 or file:9"
      expect { board[9, 1] }.to raise_error ArgumentError, "invalid rank:9 or file:1"
      expect { board[0, 1] = Piece.new(:em) }.to raise_error ArgumentError, "invalid rank:0 or file:1"
      expect { board[1, 0] = Piece.new(:em) }.to raise_error ArgumentError, "invalid rank:1 or file:0"
      expect { board[1, 9] = Piece.new(:em) }.to raise_error ArgumentError, "invalid rank:1 or file:9"
      expect { board[9, 1] = Piece.new(:em) }.to raise_error ArgumentError, "invalid rank:9 or file:1"
    end

    it "should raise an error when invalid piece" do
      expect { board[1, 1] =  1 }.to raise_error ArgumentError, "invalid value 1 for Board. Must be of class Piece"
    end
  end

  context "'[]' method with square symbol" do
    let(:board) { Board.new }
    it "should allow reading" do
      board.data[:a1] = Piece.new(:bk)
      expect(board[:a1]).to be_instance_of(Piece)
    end

    it "should allow writting" do
      board[:a1] = Piece.new(:bk)
      expect(board.data[:a1]).to be_instance_of(Piece)
    end

    it "should raise an error when invalid square" do
      expect { board[:i1] }.to raise_error ArgumentError, "invalid square i1"
      expect { board[:a0] }.to raise_error ArgumentError, "invalid square a0"
      expect { board[:a9] }.to raise_error ArgumentError, "invalid square a9"
    end

    it "should raise an error when invalid piece" do
      expect { board[:a1] = 1 }.to raise_error ArgumentError, "invalid value 1 for Board. Must be of class Piece"
    end
  end
end