require_relative '../lib/app'
require_relative '../lib/app'

class BoardSquares
  attr_accessor :data
end

describe "board", :board do
  it "'[]' method should allow reading" do
    board = BoardSquares.new
    board.data[:a1] = Piece.new
    expect(board[1, 1]).to be_instance_of(Piece)
  end

  it "'[]' method should allow writting" do
    board = BoardSquares.new
    board[1, 1] = Piece.new
    expect(board.data[:a1]).to be_instance_of(Piece)
  end

  it "'[]' method should raise an error when out of bound" do
    board = BoardSquares.new
    expect { board[0, 1] }.to raise_error ArgumentError, "invalid rank:0 or file:1"
    expect { board[1, 0] }.to raise_error ArgumentError, "invalid rank:1 or file:0"
    expect { board[1, 9] }.to raise_error ArgumentError, "invalid rank:1 or file:9"
    expect { board[9, 1] }.to raise_error ArgumentError, "invalid rank:9 or file:1"
    expect { board[0, 1] = 0 }.to raise_error ArgumentError, "invalid rank:0 or file:1"
    expect { board[1, 0] = 0 }.to raise_error ArgumentError, "invalid rank:1 or file:0"
    expect { board[1, 9] = 0 }.to raise_error ArgumentError, "invalid rank:1 or file:9"
    expect { board[9, 1] = 0 }.to raise_error ArgumentError, "invalid rank:9 or file:1"
  end

  it "'[]' method should raise an error when invalid piece" do
    board = BoardSquares.new
    expect { board[1, 1] =  1 }.to raise_error ArgumentError, "invalid value 1 for BoardSquares. Must be 0 or of class Piece"
  end

  it "'square' method should allow reading" do
    board = BoardSquares.new
    board.data[:a1] = Piece.new
    expect(board.square(:a1)).to be_instance_of(Piece)
  end

  it "'square' method should allow writting" do
    board = BoardSquares.new
    board.square(:a1, Piece.new)
    expect(board.data[:a1]).to be_instance_of(Piece)
  end

  it "'square' method raise an error when invalid square" do
    board = BoardSquares.new
    expect{ board.square(:i1) }.to raise_error ArgumentError, "invalid square i1"
    expect{ board.square(:a0) }.to raise_error ArgumentError, "invalid square a0"
    expect{ board.square(:a9) }.to raise_error ArgumentError, "invalid square a9"
  end

end