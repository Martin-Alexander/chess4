module GenerateMovesSetupModule
 
 def setup
    @turnplayer_color = white_to_move ? :white : :black 
    @board = @game_state.board
  end

  def turnplayer_squares
    start_time = Time.now

    output = []
    each_square do |square|
      if @board[square].color == turn_player_color
        output << Square.new(square)
      end
    end

    output
  end

  def moves_of(square)
    send(@board[square.symbol].piece, square)
  end
end