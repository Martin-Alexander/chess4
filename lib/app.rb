require 'byebug'

require_relative 'models/chess'
require_relative 'models/square'
require_relative 'models/piece'
require_relative 'models/board'
require_relative 'models/move'
require_relative 'models/game_state'

require_relative 'processes/modules/helpers/piece_moves_helper'
require_relative 'processes/modules/helpers/chess_helper'
require_relative 'processes/modules/piece_moves'
require_relative 'processes/modules/legal_moves_setup'
require_relative 'processes/classes/legal_moves'

require_relative 'config/flags'