# Copyright Michael Mell 2010, 2014
#
# A Tic Tac Toe engine for games of any number of dimensions, players and grid size.
# See SampleGames for usage.

require_relative 'multi_tic_tac_toe/player'
require_relative 'multi_tic_tac_toe/position'
require_relative 'multi_tic_tac_toe/game'
require_relative 'multi_tic_tac_toe/version'

module MultiTicTacToe
  def self.version
    Version
  end
end
