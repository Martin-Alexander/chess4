require 'byebug'

require_relative 'models/chess'
require_relative 'models/square'
require_relative 'models/piece'
require_relative 'models/board'
require_relative 'models/move'
require_relative 'models/game_state'

require_relative 'processes/chess_helper'

require_relative 'processes/move_generation/move_legality/move_legality'
require_relative 'processes/move_generation/piece_moves/piece_moves_helper'
require_relative 'processes/move_generation/piece_moves/piece_moves'
require_relative 'processes/move_generation/setup'
require_relative 'processes/move_generation/main'


require_relative 'config/flags'