#! /usr/bin/env ruby

# > ruby ./SampleGames.rb
#

require_relative 'lib/multi_tic_tac_toe'

# Each move sets a position on each dimension to define a claimed position.

g = MultiTicTacToe::Game.new(2) # 2 dimensions, 3 grid, 2 players
g.move( 0, 0 ) # P1
g.move( 1, 0 )
g.move( 0, 1 ) # P1
g.move( 1, 1 )
g.move( 0, 2 ) # P1 winner!

g = MultiTicTacToe::Game.new(3, 4) # 3 dimensions, 4 grid, 2 players
g.move( 0, 0, 1 ) # P1
g.move( 1, 0, 1 )
puts "\n *** no winner yet ..."

g = MultiTicTacToe::Game.new(3, 4, 3) # 3 dimensions, 4 grid, 3 players
g.move( 0, 0, 0 ) # P1
g.move( 0, 0, 1 )
g.move( 0, 0, 2 )
g.move( 1, 1, 1 ) # P1
g.move( 1, 0, 1 )
g.move( 1, 0, 2 )
g.move( 2, 2, 2 ) # P1
g.move( 2, 0, 1 )
g.move( 2, 0, 2 )
g.move( 3, 3, 3 ) # P1 winner!

g = MultiTicTacToe::Game.new(10, 3, 4) # 10 dimensions, 3 grid, 4 players
# Player1 wins the game on just the first two dimensions...
g.move( 0, 0 ) # P1
g.move( 1, 0, 1 )
g.move( 1, 0, 2, 1 )
g.move( 1, 0, 2, 2 )
g.move( 0, 1 ) # P1
g.move( 1, 1, 1 )
g.move( 1, 1, 2, 1 )
g.move( 1, 1, 2, 2 )
g.move( 0, 2 ) # P1
