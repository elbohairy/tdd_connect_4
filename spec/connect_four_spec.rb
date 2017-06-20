require 'rspec'
require './connect_four'

# board should allow player to make moves
# board should update
# board should check win condition after each move
# Player class with name and symbol
# edit choose move
# loop until 'you win'


describe Board do

  describe "attributes" do

    subject do
      Board.new(:grid => [Square.new([5,5])])
    end

    it { is_expected.to respond_to(:grid) }
  end

  describe '#display' do

    let(:board2) do
      board2 = Board.new(Grid.new(5, 6))
      board2
    end

    context "when Board.grid has a 5-by-6 grid" do
      it "displays a 5-by-6 grid" do
        expect { board2.display }.to output(
"""|_ _||_ _||_ _||_ _||_ _||_ _|\n|_ _||_ _||_ _||_ _||_ _||_ _|
|_ _||_ _||_ _||_ _||_ _||_ _|\n|_ _||_ _||_ _||_ _||_ _||_ _|
|_ _||_ _||_ _||_ _||_ _||_ _|\n--0----1----2----3----4----5--"""
        ).to_stdout
      end
    end
  end

  describe '#choose_move column' do

    let(:board3) do
      board3 = Board.new(Grid.new(2,2))
      board3
    end

    context "when column 0 is chosen and available" do
      it "updates the first square in column 0 with player's symbol" do
        expect(board3.choose_move(0).symbol).to eql('X')
      end
    end

    context "when a column is chosen that is full" do
      it "it returns 'Choose again.'" do
        board3.choose_move(0)
        board3.choose_move(0)
        expect(board3.choose_move(0)).to eql('Choose again.')
        #expect { board3.choose_move(0) }.to output('Choose again.').to_stdout
      end
    end


  end

  describe '#update_grid' do
  end

  describe '#frontslash_win?' do

    let(:board4) do
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
      board4
    end

    context "when the board has a frontslash of four squares" do
      it "returns 'You win!'" do
        board4.grid.find_by_loc([3,2]).symbol = 'O'
        board4.latest_move = board4.grid.find_by_loc([3,2])
        expect( board4.frontslash_win? ).to eql("You win!")
      end
    end

    context "when the board does NOT have a frontslash win" do
      it "returns false" do
        board4.grid.find_by_loc([3,2]).symbol = 'X'
        board4.latest_move = board4.grid.find_by_loc([3,2])
        expect( board4.frontslash_win? ).to eql(false)
      end
    end
  end

  describe '#backslash_win?' do

    let(:board5) do
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
    end

    context "when the board has a backslash of four squares" do
      it "returns 'You win!'" do
        board5.grid.find_by_loc([2,4]).symbol = 'O'
        board5.latest_move = board5.grid.find_by_loc([2,4])
        expect( board5.backslash_win? ).to eql("You win!")
      end
    end

    context "when the board does NOT have a frontslash win" do
      it "returns false" do
        board5.grid.find_by_loc([2,5]).symbol = 'X'
        board5.latest_move = board5.grid.find_by_loc([2,5])
        expect( board5.backslash_win? ).to eql(false)
      end
    end
  end

  describe '#vertical_win?' do

    let(:board6) do
      board6 = Board.new(Grid.new(6, 7))
      board6.choose_move(1)
      board6.choose_move(1)
      board6.choose_move(1)
      board6
    end

    context "when the board has a vertical stack of four squares" do
      it "returns 'You win!'" do
        board6.choose_move(1)
        expect( board6.vertical_win? ).to eql("You win!")
      end
    end

    context "when the board does NOT have a vertical win" do
      it "returns false" do
        board6.grid.find_by_loc([1,3]).symbol = 'O'
        board6.latest_move = board6.grid.find_by_loc([1,3])
        expect( board6.vertical_win? ).to eql(false)
      end
    end
  end

  describe '#horizontal_win?' do

    let(:board7) do
      board7 = Board.new(Grid.new(6, 7))
      board7.choose_move(1)
      board7.choose_move(2)
      board7.choose_move(4)
      board7
    end

    context "when the board has a horizontal row of four squares" do
      it "returns 'You win!'" do
        board7.choose_move(3)
        expect( board7.horizontal_win? ).to eql("You win!")
      end
    end

    context "when the board does NOT have a horizontal win" do
      it "returns false" do
        board7.grid.find_by_loc([3,5]).symbol = 'O'
        board7.latest_move = board7.grid.find_by_loc([3,5])
        expect( board7.horizontal_win? ).to eql(false)
      end
    end
  end



end




describe Square do
  describe "attributes" do

    subject do
      Square.new(:player => nil,
                 :symbol => 'O', 
                 :position => [0, 1])
    end

    it { is_expected.to respond_to(:player) }
    it { is_expected.to respond_to(:symbol) }
    it { is_expected.to respond_to(:position) }
  end
end

describe Grid do
  describe "attributes" do

    subject do
      Grid.new(1, 2)
    end

    it { is_expected.to respond_to(:rows) }
    it { is_expected.to respond_to(:columns) }
  end


  describe '#create_grid columns, rows' do

    let(:grid1) do
      Grid.new(5, 6)
    end

    context "when given 5 rows and 6 columns" do
      it "creates an array of 30 Square members" do
        expect(grid1.members.length).to eql(30)
        expect(grid1.members.sample.is_a? Square).to be true
      end
    end

  end


  describe '#collect_members_by_row' do
    let(:grid2) do
      Grid.new(2,4)
    end

    context "when given a grid with 2 rows" do
      it "returns a hash with 2 keys" do
        expect(grid2.collect_members_by_row.length).to eql(2)
      end
    end
  end

  describe '#collect_members_by_column' do
    let(:grid3) do
      Grid.new(2,4)
    end

    context "when given a grid with 4 rows" do
      it "returns a hash with 4 keys" do
        expect(grid3.collect_members_by_column.length).to eql(4)
      end
    end
  end

  describe '#find_by_loc' do
    let(:grid4) do
      Grid.new(6,7)
    end

    context "when given the array [2,3]" do
      it "returns the Square at position [2,3]" do
        expect(grid4.find_by_loc([2,3]).position).to eql([2,3])
      end
    end

    context "when given the position [2,3] and the symbol X" do
      it "returns the Square with the symbol at position [2,3]" do
        grid4.find_by_loc([2,3]).symbol = 'X'
        expect(grid4.find_by_loc([2,3], 'X').position).to eql([2,3])
      end

      it "returns nil when the Square doesn't have that symbol" do
        grid4.find_by_loc([2,3]).symbol = 'X'
        expect(grid4.find_by_loc([2,3], 'O')).to eql(nil)
      end
    end
  end

end


describe Player do
  describe 'attributes' do

    subject do
      Player.new("Johnny", '%')
    end

    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:symbol) }

  end

end