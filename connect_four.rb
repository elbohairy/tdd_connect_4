# NOTE: for each row, there are column members. For each column, there are row members.
# E.g., in a 4-by-6 grid, where there are 4 rows and 6 columns, each row has 6 members,
# and each column has 4 members.

class Board
  attr_accessor :grid, :latest_move

  def initialize(grid)
    @grid = grid
  end


  def display
    @grid.members_by_row.each_pair do |column, memb_ary|
      memb_ary.each do |member|
        print "|_#{member.symbol}_|" 
      end
      print "\n"
    end
    @grid.rows.times do |column_no|
      print "--#{column_no}--"
    end
  end

  def choose_move col_no
    # thought I could reverse this earlier. It doesn't work.
    col_no_squares = @grid.members_by_column[col_no].reverse
    move = col_no_squares.find do |square|
      square.symbol == ' '
    end

    if move
      move.symbol = 'X'
      @latest_move = move
      return move
    else
      return "Choose again."
    end

  end

  def frontslash_win? win_condition=[@latest_move]
    # idea. collector/win condition, and another ary for checking new moves
    neg = false
    until win_condition.length >= 4 or neg
      win_condition.each do |move|
        loc = move.position

        up_and_right = @grid.find_by_loc [loc[0]+1, loc[1]-1], move.symbol
        down_and_left = @grid.find_by_loc [loc[0]-1, loc[1]+1], move.symbol
        if !win_condition.include? up_and_right and
          !win_condition.include? down_and_left and up_and_right and down_and_left
            win_condition.push up_and_right
            win_condition.push down_and_left
        elsif !win_condition.include? up_and_right and up_and_right
          win_condition.push up_and_right
        elsif !win_condition.include? down_and_left and down_and_left
          win_condition.push down_and_left
        else
          neg = true
        end
      end
    end

    if win_condition.length >= 4
      return 'You win!'
    elsif neg
      return false
    end

   
  end


  def backslash_win? win_condition=[@latest_move]
    # idea. collector/win condition, and another ary for checking new moves
    neg = false
    until win_condition.length >= 4 or neg
      win_condition.each do |move|
        loc = move.position

        up_and_left = @grid.find_by_loc [loc[0]-1, loc[1]-1], move.symbol
        down_and_right = @grid.find_by_loc [loc[0]+1, loc[1]+1], move.symbol
        if !win_condition.include? up_and_left and
          !win_condition.include? down_and_right and up_and_left and down_and_right
            win_condition.push up_and_left
            win_condition.push down_and_right
        elsif !win_condition.include? up_and_left and up_and_left
          win_condition.push up_and_left
        elsif !win_condition.include? down_and_right and down_and_right
          win_condition.push down_and_right
        else
          neg = true
        end
      end

    end

    if win_condition.length >= 4
      return 'You win!'
    elsif neg
      return false
    end

   
  end

  def vertical_win? win_condition=[@latest_move]
    # idea. collector/win condition, and another ary for checking new moves
    neg = false
    until win_condition.length >= 4 or neg
      win_condition.each do |move|
        loc = move.position
        below = @grid.find_by_loc [loc[0], loc[1]+1], move.symbol

        if !win_condition.include? below and below
            win_condition.push below
        else
          neg = true
        end
      end

    end

    if win_condition.length >= 4
      return 'You win!'
    elsif neg
      return false
    end

   
  end

  def horizontal_win? win_condition=[@latest_move]
    # idea. collector/win condition, and another ary for checking new moves
    neg = false
    until win_condition.length >= 4 or neg
      win_condition.each do |move|
        loc = move.position

        left = @grid.find_by_loc [loc[0]-1, loc[1]], move.symbol
        right = @grid.find_by_loc [loc[0]+1, loc[1]], move.symbol
        if !win_condition.include? left and
          !win_condition.include? right and left and right
            win_condition.push left
            win_condition.push right
        elsif !win_condition.include? left and left
          win_condition.push left
        elsif !win_condition.include? right and right
          win_condition.push right
        else
          neg = true
        end
      end

    end

    if win_condition.length >= 4
      return 'You win!'
    elsif neg
      return false
    end

   
  end


end

class Square
  attr_accessor :player, :symbol, :position

  def initialize(player=nil, symbol=' ', position)
    @player = player
    @symbol = symbol
    @position = position
  end

end

class Grid
  attr_accessor :members, :columns, :rows, :members_by_column, :members_by_row

  def initialize(rows, columns)
    @columns = columns
    @rows = rows
    @members_by_column = {}
    @members_by_row = {}

    create_grid rows, columns
    collect_members_by_row
    collect_members_by_column
  end

  def collect_members_by_row
    @rows.times do |row_no|
      row_members = []
      self.members.each do |member|
        if member.position[1] == row_no
          row_members.push member
        end
      end

      @members_by_row[row_no] = row_members
    end

    @members_by_row
  end

  def collect_members_by_column
    @columns.times do |column_no|
      column_members = []
      self.members.each do |member|
        if member.position[0] == column_no
          column_members.push member
        end
      end
      @members_by_column[column_no] = column_members
    end

    @members_by_column
  end


  def create_grid(rows, columns)
    members = []
    rows.times do |ypos|
      columns.times do |xpos|
        position = [xpos, ypos]
        square = Square.new(position)
        members.push square
      end
    end

    @members = members
  end

  def find_by_loc(pos, sym=nil)
    # testing helper
    if sym
      result = @members.find do |square|
        square.position == pos and
        square.symbol == sym
      end
    else
      result = @members.find do |square|
        square.position == pos
      end
    end

    if result
      result
    else
      nil
    end
  end



end


board2 = Board.new(Grid.new(6, 7))

board2.display
p "\n"
board2.choose_move(0)
p "\n"
board2.display
board2.choose_move(0)
p "\n"
board2.display
board2.choose_move(0)
p "\n"
board2.display
board2.choose_move(0)
p "\n"
board2.display
board2.choose_move(0)
p "\n"
board2.display
board2.choose_move(0)
p "\n"
board2.display
p board2.choose_move(0)
#p board2.grid.members.each {|x| print x}

#p board2.grid.count_members_by_row

p "HHHHHHHHHHHHHHHHHHHHHHHLOOOLLOL\n"

board4 = Board.new(Grid.new(6, 7))
board4.choose_move(1)
board4.choose_move(2)
board4.choose_move(2)
board4.choose_move(3)
board4.choose_move(3)
board4.choose_move(3)
board4.grid.find_by_loc([0,5]).symbol = 'O'
board4.grid.find_by_loc([1,4]).symbol = 'O'
board4.grid.find_by_loc([2,3]).symbol = 'O'
board4.grid.find_by_loc([3,2]).symbol = 'O'
board4.latest_move = board4.grid.find_by_loc([3,2])

p board4.display

p board4.frontslash_win?

p "BLAAAAAAAAH"

board5 = Board.new(Grid.new(6, 7))
board5.choose_move(0)
board5.choose_move(0)
board5.choose_move(0)
board5.choose_move(1)
board5.choose_move(1)
board5.choose_move(2)
board5.grid.find_by_loc([0,2]).symbol = 'O'
board5.grid.find_by_loc([1,3]).symbol = 'O'
board5.grid.find_by_loc([3,5]).symbol = 'O'
board5

p board5.display

board5.grid.find_by_loc([2,4]).symbol = 'O'

p board5.display
board5.latest_move = board5.grid.find_by_loc([2,5])

p board5.backslash_win?


p "VERTICAL WANNNN"

board6 = Board.new(Grid.new(6, 7))
board6.choose_move(1)
board6.choose_move(1)
board6.choose_move(1)
board6

board6.choose_move(1)
p board6.display
p board6.vertical_win?