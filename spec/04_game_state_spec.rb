require_relative '../lib/app'

describe "game state", :game_state do
  context "initialization" do
    let(:board) { Board.new() }
    let(:castling_hash) { { wk: true, wq: true, bk: true, bq: true } }

    it "should accept a board object, a castling hash, and an en passant square" do
      expect { GameState.new(board, castling_hash, :e3) }.not_to raise_error
    end

    it "should require that 'board' be a Board object" do
      expect { GameState.new(board, castling_hash, :e3) }.not_to raise_error
      expect { GameState.new(4, castling_hash, :e3) }.to raise_error ArgumentError, "invalid board 4:Fixnum. Must be of type Board"
    end

    it "should require that 'castling_hash' to have the correct format" do
      bad_length = { wk: false, wq: true, bk: true }
      bad_piece = { wk: false, wq: true, bk: true, bb: true }
      bad_boolean = { wk: false, wq: true, bk: 1, bq: 0 }
      expect { GameState.new(board, castling_hash, :e3) }.not_to raise_error
      expect { GameState.new(board, bad_length, :e3) }.to raise_error ArgumentError, "invalid castling hash"
      expect { GameState.new(board, bad_piece, :e3) }.to raise_error ArgumentError, "invalid castling hash"
      expect { GameState.new(board, bad_boolean, :e3) }.to raise_error ArgumentError, "invalid castling hash"
    end

    it "should require that 'enpassant' be a valid square" do
      expect { GameState.new(board, castling_hash, :e3) }.not_to raise_error
      expect { GameState.new(board, castling_hash, :i3) }.to raise_error ArgumentError, "invalid en passant square"
      expect { GameState.new(board, castling_hash, :e0) }.to raise_error ArgumentError, "invalid en passant square"
    end
  end
end