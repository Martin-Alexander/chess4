class GenerateMoves
  attr_reader :legal_moves

  include ChessHelpersModule
  include GenerateMovesSetupModule

  include PieceMovesModule
  include PieceMovesHelpersModule

  include MoveLegalityModule

  def initialize(game_state)
    @game_state = game_state
    setup
    @legal_moves = run
  end

  def run
    all_legal_moves = []
    turnplayer_squares.each do |square|
      moves_of(square).each do |move|
      	# TODO:
      	# if king_safe?(@board, move)
	        all_legal_moves << move
        # end
      end
    end

    all_legal_moves.flatten
  end
end