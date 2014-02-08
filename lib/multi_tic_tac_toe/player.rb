module MultiTicTacToe

  class Player
    def initialize(ix)
      @ix = ix
    end

    def to_s
      "Player#{@ix}"
    end

    def inspect # need this for game_board_display()
      to_s
    end

    def self.create_players(players_ct)
      (0...players_ct).map { |e| new(e) }
    end

  end

end
