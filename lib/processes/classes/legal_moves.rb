class LegalMoves
  extend LegalMovesModule

  def self.find(game_state, move)
    run(game_state, move)
  end
end