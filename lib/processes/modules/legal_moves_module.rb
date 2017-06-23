module LegalMovesModule
  include Helpers

  def run

    all_legal_moves = []

    setup

    turnplayer_pieces.each do |square|
      moves_of(square).each do |move|
        print move
        # if is_legal?(move)
        #   all_legal_moves << move
        # end 
      end
    end
  end

  def setup
    @turnplayer_color = @game_state.white_to_move ? :white : :black 
    @board = @game_state.board
  end

  def turnplayer_pieces
    start_time = Time.now

    output = []
    each_rankfile do |rank, file|
      if @board[rank, file].color == @turnplayer_color
        output << @board[rank, file]
      end
    end

    output
  end

  def moves_of(square)
    send(square.piece)
  end

  def pawn
    []
  end

  def knight
    []
  end

  def bishop
    []
  end

  def rook
    []
  end

  def queen
    []
  end

  def king
    []
  end
end