module MultiTicTacToe

  class Player
    def initialize(ix)
      @ix = ix
    end

    # a readable name for display
    def name
      "Player#{@ix}"
    end
    alias_method :to_s, :name
    alias_method :inspect, :name # used in line.inspect

    def self.create_players(players_ct)
      (0...players_ct).map { |e| new(e +1) }
    end

  end

end
