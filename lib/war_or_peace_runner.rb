require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game_setup'
require './lib/card_generator'

filename = "cards.txt"
game_setup = GameSetup.new(filename)
game_setup.start
