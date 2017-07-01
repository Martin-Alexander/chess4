class LegalMoves
  attr_reader :legal_moves

  include LegalMovesModule
  
  def initialize(game_state)
    @game_state = game_state
    @legal_moves = run
  end
end