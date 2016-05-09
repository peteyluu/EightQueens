class EightQueens
  DIAGS = [[-1, -1], [-1, 1], [1, -1], [1 , 1]]

  def initialize(size)
    @board = populate(size)
    @num_queens = size

    run
  end

  def run
    solve(0)
  end

  def solve(col)
    if @num_queens == 0
      puts "You win!"
      display
      return true
    else
      (col...@board.length).each do |i|
        (0...@board.length).each do |j|
          curr_coord = [i, j]
          if queen_safe?(curr_coord)
            place_queen(curr_coord, 1)
            @num_queens -= 1
            if solve(col + 1)
              return true
            else
              place_queen(curr_coord, 0)
              @num_queens += 1
            end
          end
        end
      end
    end

    false
  end

  def place_queen(coord, type)
    x, y = coord
    @board[x][y] = type
  end

  def queen_safe?(coord)
    uldr_safe?(coord) && diags_safe?(coord)
  end

  def uldr_safe?(coord)
    x, y = coord
    (0...@board.length).each do |i|
      if @board[x][i] == 1
        return false
      end
      if @board[i][y] == 1
        return false
      end
    end
    true
  end

  def diags_safe?(coord)
    x, y = coord
    (0...@board.length).each do |i|
      if in_bounds?([x - i, y - i])
        if @board[x - i][y - i] == 1
          return false
        end
      end
      if in_bounds?([x - i, y + i])
        if @board[x - i][y + i] == 1
          return false
        end
      end
      if in_bounds?([x + i, y - i])
        if @board[x + i][y - i] == 1
          return false
        end
      end
      if in_bounds?([x + i, y + i])
        if @board[x + i][y + i] == 1
          return false
        end
      end
    end
    true
  end

  def in_bounds?(coord)
    x, y = coord
    x.between?(0, @board.length - 1) && y.between?(0, @board.length - 1)
  end

  def [](row, col)
    @board[row][col]
  end

  def display
    @board.each do |ary|
      puts ary.join(" ")
    end
  end

  def populate(size)
    grid = Array.new(size) { Array.new(size) }
    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        grid[i][j] = 0
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Please enter size for the chess board (i.e. 8 for 8x8)"
  input = Integer(gets.chomp)
  q = EightQueens.new(input)
end
