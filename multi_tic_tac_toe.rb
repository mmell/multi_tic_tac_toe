# Copyright Michael Mell 2010. All rights reserved.
#
# A Tic Tac Toe engine for games of any number of dimensions, players and grid size.
#

module MultiTicTacToe

  class Player
    def initialize(ix)
      @ix = ix
    end

    def to_s
      "P#{@ix}"
    end

    def inspect # need this for game_board_display()
      to_s
    end

    def self.create_players(players_ct)
      (0...players_ct).map { |e| new(e) }
    end

  end

  class Game
    def initialize( dimensions = 2, player_ct = 2, grid_size = 3)
      puts "\n\n=============================================
  Starting game with #{dimensions} dimensions and #{player_ct} players on a board grid with #{grid_size} positions per dimension."
      @dimensions, @player_ct, @grid_size = dimensions, player_ct, grid_size
      @players, @current_player = Player.create_players(player_ct), 0
      @plays, @points, @lines = [], {}, {}
      generate_dimension_points(0, (0...@grid_size).map { |e| [e] } ).each { |e|
        @points[e] = nil
      }
      generate_lines
      game_board_display
    end

    # recursively generate all the points in a dimension
    def generate_dimension_points( dimension, points )
      return points if dimension +1 == @dimensions
      new_points = []
      (0...@grid_size).each { |grid|
        points.each { |p|
          pp = p.dup
          pp << grid
          new_points << pp
        }
      }
      generate_dimension_points( dimension +1, new_points)
    end

    # map points on a line to the line
    def map_line_to_points(line)
      line.each { |point|
        @lines[point] ||= []
        @lines[point] << line unless @lines[point].include?(line) or @lines[point].include?(line.reverse)
      }
    end

    # map each point to all the lines on which it is found
    def generate_lines
      @points.keys.each { |point|
        next unless ( point.include?(0) or point.include?(@grid_size - 1) ) # only process edges
        increments = (0...point.size).map { |ix|
          case point[ix]
          when 0
            line_point, line = point.dup, [point.dup]
            (1...@grid_size).each { |grid|
              line_point[ix] += 1 # this line will increment only on the ix dimension
              line << line_point.dup
            }
            map_line_to_points(line)
            1
          when @grid_size - 1
            -1
          else
            0
          end
        }
        # do the diagonal
        line_point, line = point.dup, [point.dup]
        (1...@grid_size).each { |grid|
          (0...@dimensions).each { |ix| line_point[ix] += increments[ix] }
          line << line_point.dup
        }
        map_line_to_points(line)
      }
    end

    def next_player
      @current_player = @current_player >= (@player_ct - 1) ? 0 : @current_player + 1
    end

    def get_player
      @players[@current_player]
    end

    def check_move(point)
      raise RuntimeError, "missing point" unless point.size == @dimensions
      raise RuntimeError, "position taken" if @plays.include?(point)
      raise RuntimeError, "position off grid" if point.max >= @grid_size

      @plays << point
    end

    # current player claims a point
    def move(point)
      check_move(point)
      if @game_over
        puts @game_over
        return
      end
      puts "\nPlayer #{get_player} claims position #{point} in move ##{@plays.size}."
      @points[point] = get_player
      game_board_display
      check_winner(point)
      next_player
    end

    def check_winner(point)
      player_line = Array.new(@grid_size, get_player)
      @lines[point].each { |line|
        if line.map { |point| @points[point] } == player_line
          set_game_over("\n *** Player #{get_player} won on line: #{line.inspect}.")
          return
        end
      }
      set_game_over("\n *** Game ended in a Draw.") if @plays.size == @points.size
    end

    def set_game_over(s)
      puts @game_over ||= s
    end

    def game_board_display
      puts @points.inspect # this is interesting but messy on big boards
    end

  end
end
