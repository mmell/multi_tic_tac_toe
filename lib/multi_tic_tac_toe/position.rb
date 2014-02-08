module MultiTicTacToe

  class Position < Array
    attr_reader :grid_size

    def initialize(dimension_size, grid_size, *dimension_positions)
      super dimension_positions.fill(dimension_positions.size...dimension_size) { |e| 0 }
      @grid_size = grid_size
    end

    alias_method :dimensions, :size # number of dimensions

    def lines
      lines = dimension_matrix.map { |e| line_in(e) }.delete_if { |e| e.nil? }
      lines.uniq! # FIXME! why is this needed?
      lines
    end

    def line_in(matrix_elements = [0])
      return nil unless motion_in_these_dimensions?(matrix_elements)
      line = [self]
      (1...grid_size).each { |step|
        new_position = line[-1].dup
        matrix_elements.each { |dimension|
          new_position[dimension] += step_increments[dimension]
        }
        line << new_position
      }
      line
    end

    def step_increments
      @increments ||= self.map { |e|
        case e
        when 0
          1 # lines move in positive direction in this dimension
        when (grid_size - 1)
          -1 # lines move in negative direction in this dimension
        else
          0 # no line originates in this dimension
        end
      }
    end

    def motion_in_these_dimensions?(matrix_elements)
      matrix_elements.each { |e| return true if step_increments[e] != 0 }
      false
    end

    def dimension_matrix(start = 0, matrix = []) # recurses
      return matrix if start >= dimensions
      new_matrix = []
      (start...dimensions).each { |d|
        if start == 0
          new_matrix << [d]
        else
          matrix.each { |parent|
            new_matrix << parent + [d] unless parent.include?(d)
          }
        end
      }
      matrix + dimension_matrix(start +1, new_matrix)
    end

  end

end
