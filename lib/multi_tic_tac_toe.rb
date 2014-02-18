require_relative 'multi_tic_tac_toe/player'
require_relative 'multi_tic_tac_toe/position'
require_relative 'multi_tic_tac_toe/game'
require_relative 'multi_tic_tac_toe/version'

module MultiTicTacToe
  def self.version
    Version
  end
end
