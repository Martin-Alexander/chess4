class LegalMoves
  include LegalMovesModule
  
  def initialize(game_state, move)
    @game_state = game_state
    @move = move
    run
  end
end