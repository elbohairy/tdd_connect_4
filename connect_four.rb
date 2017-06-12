

class Board
  attr_accessor :grid

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

end


board2 = Board.new(Grid.new(7, 7))

board2.display

p board2.grid.members.sample.inspect


#p board2.grid.members.each {|x| print x}

#p board2.grid.count_members_by_row

