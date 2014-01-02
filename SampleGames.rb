# > ruby ./SampleGames.rb
#

require_relative 'multi_tic_tac_toe'

# Each move sets a position on each dimension to define a claimed position.

g = MultiTicTacToe::Game.new(2) # 2 dimensions; 2 players; 3 grid
g.move( [0, 0] ) # P1
g.move( [1, 0] )
g.move( [0, 1] ) # P1
g.move( [1, 1] )
g.move( [0, 2] ) # P1 winner!

g = MultiTicTacToe::Game.new(3) # 3 dimensions; 2 players; 3 grid
g.move( [0, 0, 1] ) # P1
g.move( [1, 0, 1] )
puts "\n *** no winner yet ..."

#g = MultiTicTacToe::Game.new(3, 3, 4) # 3 dimensions; 3 players; 4 grid
#g.move( [0, 0, 0] ) # P1
#g.move( [1, 0, 1] )
#g.move( [1, 0, 0] )
#g.move( [1, 1, 1] ) # P1
#g.move( [0, 0, 1] )
#g.move( [0, 1, 1] )
#g.move( [2, 2, 2] ) # P1
#g.move( [1, 2, 1] )
#g.move( [1, 3, 1] )
#g.move( [3, 3, 3] ) # P1 winner!

# g = MultiTicTacToe::Game.new(10, 4) #  # 10 dimensions 4 players 3 grid. would take 15 hours to initialize on my MacBook Pro
