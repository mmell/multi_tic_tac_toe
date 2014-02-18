module MultiTicTacToe

  class Position < Array

    def initialize(dimension_size, grid_size, *dimension_positions)
      super dimension_positions.fill(dimension_positions.size...dimension_size) { |e| 0 }
      @grid_size = grid_size
    end

    alias_method :dimensions, :size # number of dimensions

    # all of the lines through this Position
    def lines
      dimension_matrix.map { |e| line_in(e) }.delete_if { |e| e.nil? }
    end

    # get the line that changes in `matrix_elements` dimensions
    def line_in(matrix_elements = [0])
      matrix_elements.each { |dimension|
        return nil unless self[dimension] == self[matrix_elements[0]] # no line in these dimensions
      }
      line = [line_start(matrix_elements)]
      (1...@grid_size).each { |step|
        new_position = line[-1].dup
        matrix_elements.each { |dimension|
          new_position[dimension] += 1
        }
        line << new_position
      }
      line
    end

    # get the beginning endpoint for #line_in(matrix_elements)
    def line_start(matrix_elements = [0])
      return self if self[matrix_elements[0]] == 0
      beginning = self.dup
      matrix_elements.each { |dimension| beginning[dimension] = 0 }
      beginning
    end

    # return every combination of dimensions. e.g. [[0], [1], [0, 1]]
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
