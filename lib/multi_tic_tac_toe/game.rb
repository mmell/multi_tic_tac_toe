module MultiTicTacToe

  class Game
    attr_reader :players

    def initialize( dimensions = 2, grid_size = 3, player_ct: 2, message: true)
      message "\n\n=============================================
  Starting game with #{dimensions} dimensions and #{player_ct} players on a board grid with #{grid_size} positions per dimension."
      @dimensions, @player_ct, @grid_size, @message = dimensions, player_ct, grid_size, message
      @players, @current_player = Player.create_players(player_ct), 0
      @num_positions, @moves = (grid_size ** dimensions), {}
    end

    def next_player
      @current_player = @current_player >= (@player_ct - 1) ? 0 : @current_player + 1
    end

    def current_player
      @players[@current_player]
    end

    def valid_move?(position)
      # FIXME handle invalid moves with grace
      raise RuntimeError, "invalid position" unless position.size == @dimensions # Position class fills missing dimensions
      raise RuntimeError, "position taken" if @moves.keys.include?(position)
      raise RuntimeError, "position off grid" if position.max >= @grid_size
    end

    # current player claims a position
    def move(*dimension_positions)
      message "The game is over." and return if game_over?
      position = Position.new(@dimensions, @grid_size, *dimension_positions)
      valid_move?(position)
      message "\n#{current_player} claims position #{position} in move ##{@moves.size}."
      @moves[position] = current_player
      game_board_display
      return if check_winner(position)
      next_player
    end

    def check_winner(position)
      game_over("Game ends in a Draw.") if board_full?
      position.lines.each { |line|
        if (line.select { |line_pos| @moves[line_pos] != current_player }.empty?)
          game_over("#{current_player} wins on line: #{line.inspect}.")
          return true
        end
      }
      false
    end

    def board_full?
      @num_positions == @moves.size
    end

    def game_over?
      !!@game_over
    end

    def winner
      @game_over and @moves.values.last
    end

    def game_over(s)
      @game_over = true
      message "\n *** #{s}"
    end

    def message(s)
      puts s if @message
    end

    def game_board_display
      message @moves.inspect # this is too messy for big games
    end

  end
end
