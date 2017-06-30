require 'byebug'

require_relative 'models/chess'
require_relative 'models/square'
require_relative 'models/piece'
require_relative 'models/board'
require_relative 'models/move'
require_relative 'models/game_state'

require_relative 'processes/modules/helpers'
require_relative 'processes/modules/legal_moves_module'
require_relative 'processes/classes/legal_moves'

MODEL_VALIDATIONS = true
PERFORMANCE_TESTING = true