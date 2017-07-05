class LegalMoves
  attr_reader :legal_moves

  include LegalMovesModule
  
  def initialize(game_state)
    @game_state = game_state
    setup
    @legal_moves = run
  end

  def setup
    @turnplayer_color = @game_state.white_to_move ? :white : :black 
    @board = @game_state.board
  end

  # Workhorse of the game
  def run
    all_legal_moves = []
    turnplayer_squares.each do |square|
      moves_of(square).each do |move|
      	# TODO:
      	# if GenerateBoard.new(@board, move).king_safe?
	        all_legal_moves << move
        # end
      end
    end

    all_legal_moves.flatten
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
end