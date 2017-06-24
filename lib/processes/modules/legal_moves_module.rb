module LegalMovesModule
  include Helpers

  def run

    all_legal_moves = []

    setup

    turnplayer_squares.each do |square|
      moves_of(square).each do |move|
        print move
        # if king_safe?(move)
        #   all_legal_moves << move
        # end 
      end
    end
  end

  def setup
    @turnplayer_color = @game_state.white_to_move ? :white : :black 
    @board = @game_state.board
    p @board.to_s
  end

  def turnplayer_squares
    start_time = Time.now

    output = []
    each_square do |square|
      if @board[square].color == @turnplayer_color
        output << Square.new(square)
      end
    end

    output
  end

  def moves_of(square)
    send(@board[square.symbol].piece, square)
  end

  def king_safe?
  end

  def pawn(square)
    output = []
    move_one = @board.white_to_move ? 1 : -1
    move_two = @board.white_to_move ? 2 : -2
    rank, file = square.rank, square.file

    if @board[rank + move_one, file].empty?
      output << Move.new(square, square[move_one, 0])
    end
  end

  def knight(square)
    ['knight ']
  end

  def bishop(square)
    ['bishop ']
  end

  def rook(square)
    ['rook ']
  end

  def queen(square)
    ['queen ']
  end

  def king(square)
    ['king ']
  end
end